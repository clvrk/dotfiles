<div align="center">
  <h1>Clark's dotfiles</h1>
</div>

These are my `dotfiles` that I use on every [**Arch Linux**](https://archlinux.org/) Desktop install. They include configurations for [**bspwm**](https://github.com/baskerville/bspwm) and [**sxhkd**](https://github.com/baskerville/sxhkd), [**picom**](https://github.com/yshui/picom), [**Polybar**](https://github.com/polybar/polybar), [**rofi**](https://github.com/davatorium/rofi), [**dunst**](https://github.com/dunst-project/dunst), [**Alacritty**](https://github.com/alacritty/alacritty) and [**urxvt**](https://wiki.archlinux.org/index.php/rxvt-unicode), such as my `.bashrc`, `.xinitrc` and several aliases defined in `.bash_aliases`.

## Getting started
**Note:** Please install the [base dependencies](#base-dependencies) (at least) first and then continue cloning this repository!

To get my `dotfiles` it is recommended to use a [bare git repo](). \
First, `cd` into a directory where you want to store the bare git repo, as an example let us use `$HOME/repos/`:
```bash
$ mkdir -v ~/repos && cd ~/repos
```
  clone this repository as a bare repo using:
```bash
$ git clone --bare https://github.com/clarkx86/dotfiles.git
```
Now set up the following alias for the current shell session (if you chose a different directory than `$HOME/repos/`, replace the value of `--git-dir` with your directory and its git bare sub-directory):
```bash
$ alias dotfiles='git --git-dir=$HOME/repos/dotfiles.git --work-tree=$HOME'
```
Finally, checkout the actual files:
```bash
dotfiles checkout
```
Now logout:
```bash
logout
```
Now simply login again and have fun!

## Dependencies
### Base dependencies
These packages are **required** for my configuration to work.

**Official:**
```
# pacman -S git openssh bspwm sxhkd xwallpaper rofi dunst alacritty ttf-ubuntu-font-family breeze-gtk jack2 qjackctl alsa-utils
```

**AUR:** \
[picom (git) *](https://aur.archlinux.org/packages/picom-git/) \
[Polybar](https://aur.archlinux.org/packages/polybar/)

\* *picom git release is required for kawase blur*


### Optional dependencies
These packages are completely optional, however it is recommended to install them anyway, e.g. for [my scripts]() to work.
#### Script dependencies
These dependencies are optional and, though recommended, only required for the included scripts to work:
```
# pacman -S rclone jq bc youtube-dl 
```

#### Additional development packages
**Official:**
```
# pacman -S docker dotnet-sdk
```
**AUR:** \
[Visual Studio Code (Microsoft branded *)]()

\* *The Microsoft branded release is required for debugging C# applications* 


#### Software recommendations
Cool and awesome software that I probably will need after every new installation.
**Official:**
```
# pacman -S keepassxc firefox-developer-edition thunderbird neomutt neovim zip unzip gimp inkscape blender 
```
**AUR:** \
[Spotify]()