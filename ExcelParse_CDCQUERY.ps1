$ExcelFileDir=Read-Host "FileDir"
$ExcelPWd=Read-Host "Password" -AsSecureString
$ExcelPWd=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ExcelPWd)
$ExcelPWd=[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($ExcelPWd)
$temp=@(dir $ExcelFileDir -Name -Include CDC_*_QUERY*.xlsx)
$ExcelObj = $null
$ExcelObj = New-Object -ComObject Excel.Application
for($i=0;$i-lt$temp.Length;$i++){
$ExcelWorkBook = $ExcelObj.Workbooks.Open($ExcelFileDir+'\'+$temp[$i],0,0,5,$ExcelPWd)
<#�p��C�Ƶw��2�k
$rowcount1 = $ExcelWorkBook.sheets.item(1).UsedRange.Rows.Count
$rowcount1 = $rowcount1 - 2
$rowcount2 = $ExcelWorkBook.sheets.item(2).UsedRange.Rows.Count
$rowcount2 = $rowcount2 - 2
if($rowcount1-lt0){$rowcount1=0}
if($rowcount2-lt0){$rowcount2=0}#>
$ftype=$temp[$i].Split("_")[1]
switch($ftype){
	'NIA'{
		#1100909�߰�hyweb�T�{�J�X�Ҥ���i�ॼ����������
		#$search=$temp[$i].Split("_")[3]
		$search='\d{8}'
		#��sheet��1row��row1c�զr��A1��match��False���|�Qcount:1�G�w�[1
		$row1c="A"+($ExcelWorkBook.sheets.item(1).UsedRange.Rows.Count+1)
		$row1a=$ExcelWorkBook.sheets.item(1).Range("A1",$row1c).Value2
		$rowcount1=($row1a-match$search).Count
		$row2c="A"+($ExcelWorkBook.sheets.item(2).UsedRange.Rows.Count+1)
		$row2a=$ExcelWorkBook.sheets.item(2).Range("A1",$row2c).Value2
		$rowcount2=($row2a-match$search).Count
		Write-Host $temp[$i] : $rowcount1,$rowcount2
		$ExcelObj.Workbooks.Close()
		$rocn1sum+=$rowcount1
		$rocn2sum+=$rowcount2
		break
	}
	'NCC'{
		$search='[A-Z]\d{9}'
		$rowc="A"+($ExcelWorkBook.sheets.item(1).UsedRange.Rows.Count+1)
		$rowa=$ExcelWorkBook.sheets.item(1).Range("A1",$rowc).Value2
		$rowcount=($rowa-match$search).Count
		Write-Host $temp[$i] : $rowcount
		Write-Host �ѡu�Ҧ��ҥ~��a�Φa�ϡv�J�Ҥ�����H�����Ҧr�� $i :�@ $rowcount ��
		$ExcelObj.Workbooks.Close()
		break
	}
	
}

}
$ExcelObj.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ExcelObj)
Remove-Variable $ExcelObj
Write-Host �ѡu�Ҧ��ҥ~��a�Φa�ϡv�J�Ҥ��ȫȦW��C
Write-Host ��H : $rocn1sum
Write-Host �D���� : $rocn2sum
pause

