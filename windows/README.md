# Change Powershell Profile Path Manually
Open regedit and go to
```
HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
```
Look at the values `Personal` and `{F42EE2D3-909F-4907-8871-4C22FC0BF756}` — if either points to `%USERPROFILE%\OneDrive\Documents`, change it to:
`%USERPROFILE%\Documents`.