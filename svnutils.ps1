# SVN state infos
##################################

function writeSvnInfo {
  $untracked=$deleted=$added=$modified=0

   Write-Host(' [SVN ') -nonewline -foregroundcolor White
   switch -regex (svn st) {
       "^\?" {$untracked+=1}
       "^D"  {$deleted+=1}
       "^A"  {$added+=1}
       "^M"  {$modified+=1}         
      }
      
  $prompt_string = "+$added ~$modified -$deleted"
  Write-Host(' +' + $added) -nonewline -foregroundcolor DarkRed
  Write-Host(' ~' + $modified) -nonewline -foregroundcolor DarkRed
  Write-Host(' -' + $deleted) -nonewline -foregroundcolor DarkRed

  if ($untracked -eq 0) {}
  else { 
    $prompt_string += " !]" 
    Write-Host(' !') -nonewline -foregroundcolor DarkRed
  }

  Write-Host(']') -nonewline -foregroundcolor White
}

function isCurrentDirectorySvnRepository { 
  if ((Test-Path ".svn") -eq $TRUE) {
    return $TRUE
  }
  
  # Test within parent dirs
  $checkIn = (Get-Item .).parent
  while ($checkIn -ne $NULL) {
    $pathToTest = $checkIn.fullname + '/.svn'
    if ((Test-Path $pathToTest) -eq $TRUE) {
        return $TRUE
    } else {
        $checkIn = $checkIn.parent
    }
  }
}