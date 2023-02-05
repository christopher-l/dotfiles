#!/usr/bin/env bash

# To be used as post-processing script with Document Scanner. The first three arguments are set by
# Document Scanner. The following arguments are taken from the "Script arguments" field.

set -e

print_usage_and_exit() (
    echo "Usage: $0 file-type keep-original input-file command command-arguments ... [command [command-arguments ..] ]"
    echo ""
    echo "file-type: application/pdf"
    echo "keep-original: true | false"
    echo
    echo "Commands:"
    echo "  - high-contrast <text | text-recycle>"
    echo "  - ocr <languages>"
    echo "      Languages: \"+\"-separated list, e.g., deu+eng"
    echo "                 Install additional languages with \"tesseract-data-<lang>\" packages."
    exit 1
)

if [ "$#" -lt 3 ]; then
    print_usage_and_exit
fi

FILE_TYPE="$1"
KEEP_ORIGINAL="$2"
ORIGINAL_FILE="$3"
shift 3

function main() (
    file="$ORIGINAL_FILE"
    while [ -n "$1" ]; do
        out_file=$(mktemp -u --suffix=.pdf)
        command="$1"
        shift 1
        case "$command" in
        high-contrast)
            high_contrast "$file" "$out_file" "$1"
            shift 1
            ;;
        ocr)
            ocr "$file" "$out_file" "$1"
            shift 1
            ;;
        *)
            echo "Not a valid command: $command"
            print_usage_and_exit
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
# - arg 3: preset: 'text' | 'text-recycle'
function high_contrast() (
    echo "high_contrast $1 $2 $3"
    args=(
        -density 300 # dpi
        # FIXME: We should be compressing the image when this is the last filter, but in case we
        # apply `ocrmypdf` afterwards, it will do its own compression.
        #
        # -compress jpeg            # image compression type
        # -quality 80               # image compression quality
    )
    case "$3" in
    text)
        args+=(
            -brightness-contrast 0x30 # increase brightness by 0 and contrast by 30
        )
        ;;
    text-recycle)
        args+=(
            -channel Y                 # apply the following only to the yellow channel
            -brightness-contrast 3x0   # increase brightness by 3 and contrast by 0
            +channel                   # apply the following to all channels
            -brightness-contrast 5x50 # increase brightness by 10 and contrast by 30
            # -contrast-stretch 5%x90%   # black out at most 5% and white out at most 90% of pixels
        )
        ;;
    *)
        echo "Not a valid preset: $3"
        print_usage_and_exit
        ;;
    esac

    convert "${args[@]}" "$1" "$2"
    # Remove the title tag after image magick (convert) set it to the file name.
    exiftool -Title="" -overwrite_original "$2"
)

# Makes the pdf searchable by including an invisible layer of text extracted via OCR from images.
#
# - arg 1: in file
# - arg 2: out file
# - arg 3: language, e.g., "eng+deu"
function ocr() (
    echo "ocr $1 $2 $3"
    ocrmypdf -l "$3" "$1" "$2"   
)

main $@
