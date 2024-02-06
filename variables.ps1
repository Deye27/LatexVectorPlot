$myx = Read-Host "X component"
$myy = Read-Host "Y component"
$aangle = Read-Host "Additional angle"

$filePath = ".\Plot.tex"

$content = Get-Content $filePath

$content[11] = "\pgfmathsetmacro{\myx}{$myx}"
$content[12] = "\pgfmathsetmacro{\myy}{$myy}"
$content[13] = "\pgfmathsetmacro{\aangle}{$aangle}"

$condition = Read-Host "Custom label? [Y/N]"
if ('Y' -eq $condition)
{
    $myl = Read-Host "Label"
	
	$content[14] = "\newcommand{\mystring}{$myl}"
}
else
{
	$content[14] = "\newcommand{\mystring}{($myx,$myy)}"
}

Set-Content $filePath $content

Invoke-Expression "& pdflatex.exe $filePath"

if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully completed compilation."
} else {
    Write-Host "Error during compilation. Check the LaTeX file for details."
}

Start-Process ".\Plot.pdf"
