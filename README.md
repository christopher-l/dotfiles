These are my personal **dotfiles** I use for my machines. I am not responsible
for any torn out hair, eye damage, brain damage or other damage whatsoever
caused by looking at or using the files. Now feel free to look at or use the
files.

## License
Basically do what you like.

Occasionally I borrowed some files or snippets myself. I tried to always
reference the source. Look up the respective Github / whatever pages if you want
to use those.

## deploy.sh
I wrote a basic [bash script](./deploy.sh) that will somewhat intelligently
deploy symlinks into your home directory. You probably don't want to use it as
it is on my files but it can be used on any dotfiles folder, just leave out the
preceding dot on the first level; e.g.  `~/.vim/colors/my_fancy_colorscheme.vim`
becomes `dotfiles/vim/colors/my_fancy_colorscheme.vim`.

```
Usage: ./deploy.sh [-n] TARGET...
Create a symbolic link to each TARGET in your home directory.

  -n:  only print files to be linked without actually doing anything

Existing files or or symlinks (to files or directories) will not be
touched, but directories will be linked recursively, if the directory
already exists in home.
This script and files starting with an underscore will be ignored.

In order to deploy all files issue
        ./deploy.sh *
```
