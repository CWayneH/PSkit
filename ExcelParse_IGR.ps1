$ExcelFileDir=Read-Host "FileDir"
$ExcelPWd=Read-Host "Password" -AsSecureString
$ExcelPWd=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ExcelPWd)
$ExcelPWd=[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($ExcelPWd)
$temp=dir $ExcelFileDir -Name -Include IGR*.xlsx
$ExcelObj = $null
$ExcelObj = New-Object -ComObject Excel.Application
for($i=0;$i-lt$temp.Length;$i++){
$ExcelWorkBook = $ExcelObj.Workbooks.Open($ExcelFileDir+'\'+$temp[$i],0,0,5,$ExcelPWd)
$ftype=$temp[$i].Split("-")[0]
#��sheet��1row��row1c�զr��A1��match��False���|�Qcount:1�G�w�[1
$rowc="D"+($ExcelWorkBook.sheets.item(1).UsedRange.Rows.Count+1)
$rowa=$ExcelWorkBook.sheets.item(1).Range("D1",$rowc).Value2
$rowcount=($rowa-match'\d{8}').Count
Write-Host $temp[$i] : $rowcount
switch($ftype){
	'IGR0000003'{$rc1=$rowcount ;break}
	'IGR0000004'{$rc2=$rowcount ;break}
	'IGR0000005'{$rc3=$rowcount ;break}
	'IGR0000006'{$rc4=$rowcount ;break}
	'IGR0000001'{
		if($temp[$i].Split("-")[2]-match'\d{7}091.xlsx.xlsx'){$rc5=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}092.xlsx.xlsx'){$rc6=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}151.xlsx.xlsx'){$rc9=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}152.xlsx.xlsx'){$rc10=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}201.xlsx.xlsx'){$rc13=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}202.xlsx.xlsx'){$rc14=$rowcount}
		break
	}
	'IGR0000002'{
		if($temp[$i].Split("-")[2]-match'\d{7}091.xlsx.xlsx'){$rc7=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}092.xlsx.xlsx'){$rc8=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}151.xlsx.xlsx'){$rc11=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}152.xlsx.xlsx'){$rc12=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}201.xlsx.xlsx'){$rc15=$rowcount}
		if($temp[$i].Split("-")[2]-match'\d{7}202.xlsx.xlsx'){$rc16=$rowcount}
		break
	}
}
$ExcelObj.Workbooks.Close()
}
$ExcelObj.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ExcelObj)
Remove-Variable $ExcelObj
Write-Host �J�Ҥ��e����H�f�C�鲧�ʦW��W�U:�J�Ҳ��� $rc1 ��
Write-Host �J�Ҥ��e�D����H�f�C�鲧�ʦW��W�U:�J�Ҳ��� $rc2 ��
Write-Host �J�Ҥ��e����H�f�C�鲧�ʦW��W�U:�J�ҧR�� $rc3 ��
Write-Host �J�Ҥ��e�D����H�f�C�鲧�ʦW��W�U:�J�ҧR�� $rc4 ��
Write-Host �J�Ҥ��e����H�f�W�U�]��09�^:�J�� $rc5 ��
Write-Host �X�Ҥ��e����H�f�W�U�]��09�^:�X�� $rc6 ��
Write-Host �J�Ҥ��e�D����H�f�W�U�]��09�^:�J�� $rc7 ��
Write-Host �X�Ҥ��e�D����H�f�W�U�]��09�^:�X�� $rc8 ��
Write-Host �J�Ҥ��e����H�f�W�U�]��15�^:�J�� $rc9 ��
Write-Host �X�Ҥ��e����H�f�W�U�]��15�^:�X�� $rc10 ��
Write-Host �J�Ҥ��e�D����H�f�W�U�]��15�^:�J�� $rc11 ��
Write-Host �X�Ҥ��e�D����H�f�W�U�]��15�^:�X�� $rc12 ��
Write-Host �J�Ҥ��e����H�f�W�U�]��20�^:�J�� $rc13 ��
Write-Host �X�Ҥ��e����H�f�W�U�]��20�^:�X�� $rc14 ��
Write-Host �J�Ҥ��e�D����H�f�W�U�]��20�^:�J�� $rc15 ��
Write-Host �X�Ҥ��e�D����H�f�W�U�]��20�^:�X�� $rc16 ��
pause

