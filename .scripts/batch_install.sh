#This file is for reference only and not to be run as a script

#list packages and flatpaks on current system
apt-mark showmanual > ~/my-packages.txt
flatpak list --app --columns=application > ~/my-flatpaks.txt
snap list

#batch install packages on new system (after pruning)
for i in $(cat pkglist); do
    sudo apt-get install $i -y;
done

#batch install flatpaks on new system (after pruning)
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install $(cat ~/my-flatpaks.txt)
