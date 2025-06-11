# Optimizar Distribuciones Linux en Escritorios Virtuales VDI

# Instalar Linux

Crear medio > instalación normal … 

## Actualizar todo e instalar SW básico

```bash
sudo apt update
sudo apt full-upgrade -y
sudo apt install vim gedit vlc net-tools htop curl wget spice-vdagent qemu-guest-agent
sudo apt autoremove -y
```

## Modificar fstab

```bash
sudo nano /etc/fstab
#for every "ext4" storage, define "noatime,discard"
#cambiar xxxxx por las de tu configuracion
UUID=xxxxx-xxxxx-xxxxxx /               ext4    defaults,noatime,discard,errors=remount-ro 0       1
```

## Liberar espacio disco

```bash
cd /
sudo fstrim -a -v
```

## Reducir memoria swap

```bash
sudo sysctl vm.swappiness=1
```

## Reducir logs, establecer valores

```bash
sudo nano /etc/systemd/journald.conf
SystemMaxUse=20M
SystemKeepFree=4G
```

## Deshabilitar actualizaciones automáticas en DEBIAN

```bash
# apt-daily
sudo systemctl stop apt-daily.timer
sudo systemctl disable apt-daily.timer
 
# apt-daily-upgrade
sudo systemctl stop apt-daily-upgrade.timer
sudo systemctl disable apt-daily-upgrade.timer

# Enmascaralas para todos
sudo systemctl mask apt-daily.service
sudo systemctl mask apt-daily-upgrade.service
```

# ⭐ Fix redimensionar pantalla Kali Linux ⭐

```bash
sudo nano /etc/udev/rules.d/50-x-resize.rules
ACTION=="change",KERNEL=="card0", SUBSYSTEM=="drm", RUN+="/usr/local/bin/x-resize"

sudo nano /usr/local/bin/x-resize

#!/bin/bash
# Bash required
# Should be run as root and saved to /usr/local/bin/x-resize
# Requies udev rule: /etc/udev/rules.d/50-x-resize.rules
# udev rule content: ACTION=="change",KERNEL=="card0", SUBSYSTEM=="drm", RUN+="/usr/local/bin/x-resize" 
# Make sure auto-resize is enabled in virt-viewer/spicy
# Credit for Finding Sessions as Root: https://unix.stackexchange.com/questions/117083/how-to-get-the-list-of-all-active-x-sessions-and-owners-of-them
# Credit for Resizing via udev: https://superuser.com/questions/1183834/no-auto-resize-with-spice-and-virt-manager
## Ensure Log Directory Exists
LOG_DIR=/var/log/autores;
if [ ! -d $LOG_DIR ]; then
    mkdir $LOG_DIR;
fi
LOG_FILE=${LOG_DIR}/autores.log
## Function to find User Sessions & Resize their display
function x_resize() {
    declare -A disps usrs
    usrs=()
    disps=()
    for i in $(users);do
        [[ $i = root ]] && continue # skip root
        usrs[$i]=1
    done
    for u in "${!usrs[@]}"; do
        for i in $(sudo ps e -u "$u" | sed -rn 's/.* DISPLAY=(:[0-9]*).*/\1/p');do
            disps[$i]=$u
        done
    done
    for d in "${!disps[@]}";do
	    session_user="${disps[$d]}"
	    session_display="$d"
	    session_output=$(sudo -u "$session_user" PATH=/usr/bin DISPLAY="$session_display" xrandr | awk '/ connected/{print $1; exit; }')
	    echo "Session User: $session_user" | tee -a $LOG_FILE;
	    echo "Session Display: $session_display" | tee -a $LOG_FILE;
	    echo "Session Output: $session_output" | tee -a $LOG_FILE;
	    sudo -u "$session_user" PATH=/usr/bin DISPLAY="$session_display" xrandr --output "$session_output" --auto | tee -a $LOG_FILE;
    done
}
echo "Resize Event: $(date)" | tee -a $LOG_FILE
x_resize

sudo chmod +x /usr/local/bin/x-resize
```

# Limpiar historial terminal en Linux

```bash
echo ""  > ~/.zsh_history
echo ""  > ~/.bash_history
history -c
history -w
```