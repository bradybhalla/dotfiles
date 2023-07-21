# !/bin/zsh

# create backup folder
if [ -d backup ]; then
	# backup already exists
  read -p "Backup already exists and may be overwritten, continue? (y/n): " confirm
  if ! [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] ; then
		echo "Exiting..."
		exit 1
	fi
  rm -rf backup
fi
mkdir backup

# config files
FILES=(.gitconfig .p10k.zsh .tmux.conf .zsh_aliases .zshrc .zprofile)
for file in "${FILES[@]}"; do
	if [[ -f "$HOME/$file" ]]; then
		# file exists
		echo "$file exists, saving copy."
		mv "$HOME/$file" "backup/$file"
	fi

	cp "$file" "$HOME/$file"
done


# neovim config files
NVIM_ROOT=.config/nvim

if [[ -d "$HOME/$NVIM_ROOT" ]]; then
	# neovim config root exists
  echo "nvim config exists, saving copy."
  mkdir -p $(dirname "backup/$NVIM_ROOT")
  mv "$HOME/$NVIM_ROOT" "backup/$NVIM_ROOT"
fi

cp -r "$NVIM_ROOT" "$HOME/$NVIM_ROOT"
