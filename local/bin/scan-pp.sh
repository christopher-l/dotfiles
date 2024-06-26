#!/usr/bin/env bash

# To be used as post-processing script with Document Scanner. The first three arguments are set by
# Document Scanner. The following arguments are taken from the "Script arguments" field.

set -e

print_usage_and_exit() (
    echo "Usage: $0 file-type keep-original input-file \"mode languages\""
    echo ""
    echo "file-type: application/pdf"
    echo "keep-original: true | false"
    echo "mode: none | plain | plain-gray | recycle"
    echo "languages: \"+\"-separated list, e.g., deu+eng"
    echo "           Install additional languages with \"tesseract-data-<lang>\" packages."
    exit 1
)

if [ "$#" -lt 3 ]; then
    print_usage_and_exit
fi

FILE_TYPE="$1"
KEEP_ORIGINAL="$2"
ORIGINAL_FILE="$3"
MODE=$(echo $4 | cut -d " " -f 1)
LANGUAGES=$(echo $4 | cut -d " " -f 2)

function main() (
    file="$ORIGINAL_FILE"
    for stage in "contrast" "ocr"; do
        out_file=$(mktemp -u --suffix=.pdf)
        case "$stage" in
        contrast)
            contrast "$file" "$out_file" "$MODE"
            ;;
        ocr)
            ocr "$file" "$out_file" "$LANGUAGES"
            ;;
        esac
        if [[ "$ORIGINAL_FILE" != "$file" ]]; then
            rm "$file"
        fi
        file="$out_file"
    done

    if [[ "$KEEP_ORIGINAL" == "true" ]]; then
        if [[ $ORIGINAL_FILE != "$file" ]]; then
            mv "$file" "$(dirname "$ORIGINAL_FILE")/$(basename -s .pdf "$ORIGINAL_FILE")-post-processed.pdf"
        fi
    else
        echo "overwriting $ORIGINAL_FILE with $file"
        mv "$file" "$ORIGINAL_FILE"
    fi
)

# Increases the contrast of a color scan of a text document.
#
# - arg 1: in file
# - arg 2: out file
# - arg 3: preset: 'none' | 'plain' | 'plain-gray' | 'recycle'
function contrast() (
    echo "=== CONTRAST $3"
    args=(
        -density 300 # dpi
        # Compression options.
        # 
        # Not needed since we apply `ocrmypdf` afterwards and it will do its own compression.
        #
        # -compress jpeg            # image compression type
        # -quality 80               # image compression quality
    )
    case "$3" in
    none)
        cp "$1" "$2"
        return
        ;;
    plain)
        convert_args=(
            -brightness-contrast 0x30 # increase brightness by 0 and contrast by 30
        )
        ;;
    plain-gray)
        convert_args=(
            -brightness-contrast 0x30 # increase brightness by 0 and contrast by 30
            -set colorspace Gray
        )
        ;;
    recycle)
        convert_args=(
            -channel Y                 # apply the following only to the yellow channel
            -brightness-contrast 3x0   # increase brightness by 3 and contrast by 0
            +channel                   # apply the following to all channels
            -brightness-contrast 5x50  # increase brightness by 5 and contrast by 50
            # -contrast-stretch 5%x90%   # black out at most 5% and white out at most 90% of pixels
        )
        ;;
    *)
        echo "Not a valid preset: $3"
        print_usage_and_exit
        ;;
    esac

    magick "${args[@]}" "$1" "${convert_args[@]}" "$2"
    # Remove the title tag after image magick set it to the file name.
    exiftool -Title="" -overwrite_original "$2"
)

# Makes the pdf searchable by including an invisible layer of text extracted via OCR from images.
#
# - arg 1: in file
# - arg 2: out file
# - arg 3: language, e.g., "eng+deu"
function ocr() (
    echo "=== OCR $3"
    args=(
        # This fixes the "output file is not PDF/A" error and enables strong
        # compression.
        --force-ocr
        --language "$3"
    )
    ocrmypdf "${args[@]}" "$1" "$2"   
)

main $@
