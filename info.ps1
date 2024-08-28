#$vcodec=h264_amf
$vcodec="hevc_amf"
[int]$size=720
foreach ( $item in $args )
{
	$item=get-item -literalPath $item
	$fullname=($item).fullname
	$directoryname=($item).directoryname
	$basename=($item).basename
	$Extension=($item).Extension
	
	$result=.\ffprobe.exe -v error -select_streams v -show_entries stream=width,height,r_frame_rate -of default=noprint_wrappers=1 "$item"
	$result
	#$result=.\ffprobe.exe -v error -show_streams -of default=noprint_wrappers=1 "$item"
	#$result=.\ffprobe.exe -v error -show_streams -of default=noprint_wrappers=1 "$item"
	#$result | get-member
	$hash = @{}
	ForEach ($line in $($result -split "`r`n"))
	{
		#$line
		$name, $value = $line -split "=", 2		
		$hash[$name] = $value
		#$name, $value
	}
	$hash

}
