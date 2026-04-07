# Gaming
## Steam
To enable nvidia graphic card, one should use the following command
```console
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only VKD3D_CONFIG=dxr11,dxr PROTON_ENABLE_NVAPI=1 %command%
```

## Twintail Launcher
Here is the installation script.
```console
sudo mount --bind <the-directory> ~/.var/app/app.twintaillauncher.ttl
flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub app.twintaillauncher.ttl
```

Notice that one should edit `/etc/fstab` for permanent mount.

Now one can run the program with
```console
flatpak run app.twintaillauncher.ttl
```

## Troubleshooting
### Save git passwords
```console
git config --global credential.helper store
```

### Bluetooth is not working
Open your terminal (ghostty or kitty).

Run the Bluetooth control tool:

```console
bluetoothctl
```
Inside the [bluetooth]# prompt, run these commands in order:

```console
power on
agent on
default-agent
```


## headset connection works, but sound glitches all the time
Run
```console
pactl set-port-latency-offset <bluez_card> headset-output 125000
```
where `<bluez_card>` is
`pactl list cards short | grep bluez`

### Thunderbird cannot save password
The Fix: Delete pkcs11.txt
This file manages security modules. If it is broken, Thunderbird cannot save
passwords to its database. Deleting it forces Thunderbird to generate a fresh,
working one.

1. Close Thunderbird completely.
2. Open your terminal.
3. Navigate to your Thunderbird profile directory. It is usually inside `~/.thunderbird/`.
```console
cd ~/.thunderbird
ls
```
4. You will see a folder with a random name ending in `.default` or `.default-release`
(e.g., `a1b2c3d4.default`).
5. Enter that folder:
```console
cd *.default*
```
6. Delete the `pkcs11.txt` file:
```console
rm pkcs11.txt
```
7. Restart Thunderbird.
8. Enter your password one last time and check "Use Password Manager...". It should now stick.

### QEMU / KVM not connected
First run the following commands
```console
systemctl status virtqemud.service virtqemud.socket libvirtd.service libvirtd.socket
ls -l /run/libvirt
```
If libvirtd.socket failes, then run these commands
```console
sudo systemctl stop libvirtd.socket libvirtd.service
sudo systemctl reset-failed libvirtd.socket libvirtd.service
```

### VM setting
After setting VM, switch video to none

### VM network `default` failed
```console
sudo virsh net-list --all
sudo virsh net-start default
sudo virsh net-autostart default
```

In addition, personally, I use onecommander file viewer on windows
