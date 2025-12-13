! 
!  compile this with gfortran vb.f90 -o vb
!
program volume_brightness
    implicit none

    integer :: argc, current_vol
    logical :: is_mute, ok
    character(len=40) subcmd, arg, full_cmd

    argc = command_argument_count()
    if (argc /= 2) then
        print *, "ERROR: invalid argument"
        print *, "USAGE: vb <subcommand> <arg>"
        print *, ""
        print *, "SUBCOMMAND volume: up, down, muteness, micmuteness"
        print *, "SUBCOMMAND bright: up, down"
        stop
    end if

    call get_command_argument(1, subcmd)
    call get_command_argument(2, arg)

    full_cmd = trim(subcmd) // " " // trim(arg)
    
    select case (trim(full_cmd))
        case ("volume up")
            call get_volume(current_vol, ok)
            if (.not. ok) then
                print *, "ERROR: cannot obtain current volume"
                stop
            end if

            if (current_vol + 2 > 100) then
                call execute_command_line("pactl set-sink-volume @DEFAULT_SINK@ 100%")
            else
                call execute_command_line("pactl set-sink-volume @DEFAULT_SINK@ +2%")
            end if
        case ("volume down")
            call execute_command_line("pactl set-sink-volume @DEFAULT_SINK@ -2%")
        case ("volume muteness")
            call execute_command_line("pactl set-sink-mute @DEFAULT_SINK@ toggle")
        case ("volume micmuteness")
            call execute_command_line("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
        case ("bright up")
            call execute_command_line("brightnessctl s 5%+")
        case ("bright down")
            call execute_command_line("brightnessctl s 5%-")
    end select

contains
    subroutine get_volume(volume, ok)
        integer, intent(out) :: volume
        logical, intent(out) :: ok
        integer :: fd, ios, idx_percent, idx_slash
        character(len=150) :: cmd, line

        cmd = "pactl get-sink-volume @DEFAULT_SINK@ > /tmp/tmp_get_vol"

        call execute_command_line(cmd, wait=.true.)
        open(newunit=fd, file="/tmp/tmp_get_vol", status="old", action="read")
        read(fd, *, iostat=ios) line
        close(fd, status="delete") ! `delete` removes the temp file

        if (ios /= 0) then
            ok = .false.
            return
        end if

        ok = ios == 0
    end subroutine get_volume
end program volume_brightness
