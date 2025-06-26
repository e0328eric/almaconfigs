## Location to store
Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout

## Scancode Map
set `REG_BINARY` and value should be

```
00000000    00  00  00  00  00  00  00  00
00000008    04  00  00  00  01  00  3A  00
00000010    3A  00  01  00  2B  00  36  00
00000018    00  00  00  00
```
This makes
- ESC <-> CapsLock
- Right_Shift -> Backslash
