## headset connection works, but sound glitches all the time

Run
```console
pactl set-port-latency-offset <bluez_card> headset-output 125000
```
where `<bluez_card>` is
`pactl list cards short | grep bluez`
