# Dotfiles

This dotfiles has been tested on Ubuntu. All the remaps are just personal preferences.

## Usage

```sh
git clone https://github.com/RafaelGSS/dotfiles.git ~/.dotfiles;
# or
git clone git@github.com:RafaelGSS/dotfiles.git ~/.dotfiles;
cd ~/.dotfiles; make install;
```

## Backlights (i3wm + linux)

To control backlights, I use [light](https://haikarainen.github.io/).

Increase backlight with

```console
$ light -A 10
```

and decrease with

```console
$ light -U 10
```

## VimWatch

I recommend the use of `gitwatch` to not conflict changes between workplaces.

usage:

```console
$ gitwatch -r origin -m "Autocommit on change (%d)" -b sync .dotfiles/
```
