# dev-package-installation

List of installation inside Debian/Ubuntu.

## Usage

```sh
git clone https://github.com/RafaelGSS/dotfiles.git ~/.dotfiles;
cd ~/.dotfiles; make install;
```

## Update config
_Can be add to a hook onResume onStart_
```sh
./reload.sh
```

## Optionals

To controll backlights, I recommend [light](https://haikarainen.github.io/).

To increase just run (or add to i3 config):

```sh
light -A 10
```

and decrease
```sh
light -U 10
```
