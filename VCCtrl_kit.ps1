function Sleep-Timer($t) {
	$t..0 | ForEach-Object {
		Start-Sleep -s 1
		Write-Progress -activity "Next round in.. " -Status $_" (seconds)"
	}
}
function Input-Pwd() {
	$p = Read-Host "Password" -AsSecureString
	$p = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($p)
	$p = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($p)
	return $p
}
# $vcenter = "app.intra.mno.pqr.tw"
$vcenter = Read-Host "Enter the VC host-domain name"
$vcUsr = Read-Host "User"
# Connect-VIServer $vcenter 
# Connect-VIServer -Server $vcenter -User $vcUsr -Password $(Input-Pwd)
$region = $vcenter.Split(".")[0]
if ( $region -eq "app") { $prefix_rgn = "AP" } elseif ( $region -eq "db") { $prefix_rgn = "DB"}
$cd = Read-Host "How much countdown duration in seconds"
$vm_list_group = dir -Name -Include *.txt
$vm_list_group | ForEach-Object {
	Write-Host "round"([array]::IndexOf($vm_list_group, $_)): $_;
	if ( $_.Split("_")[0]-match$prefix_rgn) {
		# $vm_list = Get-Content C:\..\list.txt #txt file with the vm list
		$tmp = Get-Content $_;
		# Restart-VMGuest -VM $tmp -Confirm:$False;
		$hosts = $tmp-join', ';
		Write-Host "accomplished hosts:"$hosts;
		Sleep-Timer($cd);
	} else { Write-Host "Not match." }
}
# Disconnect-VIServer -Confirm:$False
pause

# version-1.0.0
# Author@CWayneH
