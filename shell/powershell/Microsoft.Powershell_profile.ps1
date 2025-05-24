Set-Alias -Name v -Value hx
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

Invoke-Expression (&starship init powershell)
