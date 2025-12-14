program virt_setup
    implicit none

    character(len=50) :: username

    print *, "input your user name"
    write(*, "(A)", advance="NO") ">>> "
    read (*, *) username

    print *, "1. Download related packages"
    call execute_command_line("sudo pacman -Syu qemu virt-manager libvirt dnsmasq ebtables iptables-nft virt-install edk2-ovmf swtpm")

    print *, "2. Enable libvirtd daemon"
    call execute_command_line("sudo systemctl enable --now libvirtd")

    print *, "3. Add group"
    call execute_command_line("sudo usermod -aG libvirt " // trim(username))

    print *, "Not reboot the system"
end program virt_setup
