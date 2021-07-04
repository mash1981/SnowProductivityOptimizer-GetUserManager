function GetUsersManagerfromAD{
param ($userid)
	
	if ($userid.Contains("\"))	{
		$userid = $userid.Split("\")[1]
	}

	#import-module activedirectory
	$user = Get-ADUser -Identity $userid -properties manager

	if (-not $user.manager) {   
		$manager = new-object PSCustomObject
		#$manager | Add-Member -Type NoteProperty -Name "myDisplayName" - Value "Application approval group" -Force   
		#$manager | Add-Member -Type NoteProperty -Name "samAccountName" - Value "..." - Force     
		$manager | Add-Member -Type NoteProperty -Name "myDisplayName" -Value "No manager found in AD" -Force
		$manager | Add-Member -Type NoteProperty -Name "samAccountName" -Value "" -Force
	}   
	else {
		$manager = Get-ADUser -Identity $user.manager -properties displayName
		$manager | Add-Member -Type NoteProperty -Name "myDisplayName" -Value "$($manager.displayName) ($($manager.samAccountName))" -Force
	}
	$manager
}
