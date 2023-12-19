
# Move any existing dotfiles files into backup directory.
DATE=`date +"%Y%m%d"`
BACKUP_DIR=$HOME/dotfiles_backup_$DATE
if [ -d "$BACKUP_DIR" ];
then
    echo "Can't backup dotfiles. $BACKUP_DIR directory already exists." 
    echo "Rename or move this directory and try installing again."
    rm -rf $HOME/.dotfiles
    return
else
    mkdir $BACKUP_DIR
fi

# Copy existing files. Rsync preserves paths.
for file in $(git -C $HOME/.dotfiles ls-tree -r --full-name --name-only HEAD)
    do 
        if [ -f $file ];
            then
                rsync -RW $file $BACKUP_DIR
                rm $file;
        fi
done

# Clone bare repo.
git clone --bare https://github.com/chadbot/dotfiles.git $HOME/.dotfiles

# Define dotfiles alias.
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Checkout files.
dotfiles checkout

# Set repo to ignore most files...
dotfiles config --local status.showUntrackedFiles no

# Set upstream branch 
dotfiles push -u origin main

# Download/install fonts.
echo "Downloading MesloLGS NF font for pretty terminal..."
cd ~/Library/Fonts && { 
    curl -Os "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
    curl -Os "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
    curl -Os "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
    curl -Os "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
    cd -; 
}

echo "Dotfiles installed! Restart shell now to finish."
