My personal **dotfiles**.

## deploy.sh
A basic [bash script](./deploy.sh) that will somewhat intelligently
deploy symlinks into your home directory. 

```
Usage: ./deploy.sh [-n] TARGET...
Create a symbolic link to each TARGET in your home directory.

  -n:  only print files to be linked without actually doing anything

Existing files or or symlinks (to files or directories) will not be
touched, but directories will be linked recursively, if the directory
already exists in home.
This script and files starting with an underscore will be ignored.
```
