#!/usr/bin/env bash
# Author:	clvrk
#		contact[at]clvrk.io
# Description:	This is a bootstrap script to install my dotfiles alongside any dependencies they require.

# Don't panic! This sketchy looking string is simply a cool base64 encoded header logo!
# If you are doubtful, simply remove this line or run the script with the "--no-logo" flag :)!
HEADER_LOGO_B64="ICBfX19fIF8gICAgICAgICAgICBfICAgIF8gICAgICAgICAgIF8gICAgICAgXyAgICBfXyBfIF8gICAgICAgICAgIAogLyBfX198IHwgX18gXyBfIF9ffCB8IF8oIClfX18gICAgX198IHwgX19fIHwgfF8gLyBfKF8pIHwgX19fICBfX18gCnwgfCAgIHwgfC8gX2AgfCAnX198IHwvIC8vLyBfX3wgIC8gX2AgfC8gXyBcfCBfX3wgfF98IHwgfC8gXyBcLyBfX3wKfCB8X19ffCB8IChffCB8IHwgIHwgICA8ICBcX18gXCB8IChffCB8IChfKSB8IHxffCAgX3wgfCB8ICBfXy9cX18gXAogXF9fX198X3xcX18sX3xffCAgfF98XF9cIHxfX18vICBcX18sX3xcX19fLyBcX198X3wgfF98X3xcX19ffHxfX18vCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK"
#
# Parse command line arguments
#

# Set defaults
ARG_INTERACTIVE=1
ARG_LOGO=1
ARG_EXPLAIN=1
ARG_SLEEP_AMOUNT=3
ARG_LOGOUT=

for (( i=1; i <= $#; i++)); do
	NEXT=${!i+1}

	case ${!i} in
		"-h" | "--help")
			echo "Usage:
	# $(basename $0) [--non-interactive, --no-explain, --sleep <amount>, --logout]
Options:
	--non-interactive	Don't prompt for user input and assume defaults where needed.
	--no-logo		Don't display the logo.
	--no-explain		Just run the auto-install script without explaining what they do.
	--sleep			Amount of seconds to sleep after explaining what's happening next (for better readability).
	--logout		Automatically logout after successfully installing everything."
			exit 0
			;;
		"--non-interactive")
			unset ARG_INTERACTIVE
			;;
		"--no-logo")
			unset ARG_LOGO
			;;
		"--no-explain")
			unset ARG_EXPLAIN
			;;
		"--sleep")
			if [ $NEXT -lt 0 ]; then echo "Sleep amount must not be smaller than 0!" && exit 1; fi
			ARG_SLEEP_AMOUNT=$NEXT
			;;
		"--logout")
			ARG_LOGOUT=1
			;;
	esac
done

if [[ $ARG_LOGO && $HEADER_LOGO_B64 ]]; then
	echo "$(echo $HEADER_LOGO_B64 | base64 -d -)"
fi

#if [[ $(whoami) != root ]]; then
#	echo -e "\u001b[31mYou must run this install script as root!\u001b[0m"
#	exit 1
#fi

function explain() {
	if [[ $ARG_EXPLAIN ]]; then
		echo "$1"
		sleep $ARG_SLEEP_AMOUNT
	fi
}

function writeSection() {
	echo -e "\n\e[1m\e[4m${1}\e[0m"
}

explain "Welcome! We are going to install Clark's dotfiles, so your new install will be up & running in no time!"

# Update package index
writeSection "UPDATING PACKAGE INDEX"
explain "First of all, we will update the package index..."
#pacman -Sy

# Install base dependencies
writeSection "INSTALLING BASE PACKAGES"
explain "Now we will install the base dependencies..."

PACKAGES_BASE=(git openssh xorg-server xorg-xinit xorg-xrandr xorg-xsetroot tmux neovim bspwm sxhkd xwallpaper rofi dunst alacritty slop scrot xclip jack2 qjackctl pulseaudio pulseaudio-jack ttf-ubuntu-font-family noto-fonts-emoji alsa-utils zsh zsh-syntax-highlighting zsh-autosuggestions breeze-gtk exa)

#pacman -S --noconfirm $(echo $PACKAGES_BASE)

# Install AUR packages
writeSection "AUR packages"
explain "These dotfiles rely on some AUR packages. We will first install \"yay\" (an AUR package manager) and then continue to install several AUR packages..."

# Create builds directory !! TODO: Ask user where to create builds directory
if [[ ! -d $HOME/builds/ ]]; then
	echo "\"builds/\" directory does not exist, creating..."
	mkdir -v "$HOME/builds/"
fi

cd "$HOME/builds/"
git clone "https://aur.archlinux.org/yay.git" && cd "yay" \
	&& makepkg -si || exit 1

# Install AUR packages with yay
PACKAGES_AUR="picom-git polybar"
#yay -S $(echo $PACKAGES_AUR)

# Install optional dependencies
writeSection "INSTALLING OPTIONAL PACKAGES"
explain "Optional packages are available, which however not required for the base funcitonality of these dotfiles, are highly recommended for some scripts to work. Do you want to install them?"

PACKAGES_OPT="usbutils rclone jq bc youtube-dl"

#pacman -S --no-confirm $PACKAGES_OPT

writeSection "CONFIGURING"
explain "We are almost done! You can now configure some settings. Don't worry, this won't take long!"

writeSection "FINISHED"
explain "All done! To activate, please log out and log back in! Enjoy :)"
