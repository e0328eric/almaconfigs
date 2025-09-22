Set-Alias -Name v -Value nvim
Set-Alias -Name lg -Value lazygit
Set-Alias -Name touch -Value New-Item

# alias paths
function notetaking {
	set-location '~\Nextcloud\TeX_Documents\NoteTaking\'
}
function minireport {
	set-location '~\Nextcloud\TeX_Documents\Mini_Report\'
}
function teachingf {
	set-location '~\Nextcloud\TeX_Documents\TF\'
}
function nvimcfg {
    set-location $env:LOCALAPPDATA + '\nvim'
}

function cfmtcp {
    Copy-Item -Path '~\Github\arch-almagest\format\.clang-format' -Destination '.\.clang-format'
}

function ln ($path, $symlink) {
    New-Item -Path $symlink -ItemType SymbolicLink -Value $path
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

oh-my-posh init pwsh --config C:\Users\almag\Github\arch-almagest\shell\powershell\emodipt-extend.omp.json | Invoke-Expression
