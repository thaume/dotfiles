# Writing the path
#####################################

function writePath {
  $path = ""

  #Split the path to only display the parent folder
  $pathbits = ([string]$pwd).split("\", [System.StringSplitOptions]::RemoveEmptyEntries)
  if($pathbits.length -eq 1) {
    $path = $pathbits[0] + "\"
  } else {
    $path = $pathbits[$pathbits.length - 1]
  }

  # Get user name / current directory
  $userLocation = $env:username + '@' + [System.Environment]::MachineName
  $host.UI.RawUi.WindowTitle = $userLocation
  Write-Host($userLocation) -nonewline -foregroundcolor Magenta 
  Write-Host(" "+$path) -nonewline -foregroundcolor White
}