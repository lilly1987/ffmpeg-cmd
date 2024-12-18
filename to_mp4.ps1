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
	
	$result=.\ffprobe.exe -v error -show_entries stream=width,height,r_frame_rate -of default=noprint_wrappers=1 "$item"
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
	
	$short=$hash["width"]
	if( $hash["width"] -gt $hash["height"] ){
		$short=$hash["height"]
	}
	
	if( [int]$short -gt $size ){
		#echo true
		#.\ffmpeg.exe -i "$item" -y -vf "scale='if(gt(iw\,ih),-2,$size)':'if(gt(iw\,ih),$size,-2)',setsar=1:1" -c:a copy -vcodec $vcodec "$directoryname\$BaseName-result$Extension"	
		.\ffmpeg.exe -i "$item" -y -movflags faststart -pix_fmt yuv420p -vf "scale='if(gt(iw\,ih),-2,ceil($size/2)*2)':'if(gt(iw\,ih),ceil($size/2)*2,-2)',setsar=1:1" -c:a copy -vcodec $vcodec "$directoryname\$BaseName-result.mp4"	
	}else{
		.\ffmpeg.exe -i "$item" -y -movflags faststart -pix_fmt yuv420p -vf "scale='if(gt(iw\,ih),-2,ceil($short/2)*2)':'if(gt(iw\,ih),ceil($short/2)*2,-2)',setsar=1:1" -c:a copy -vcodec $vcodec "$directoryname\$BaseName-result.mp4"	
		#echo false		
	}
}
	#$directoryname
	#$basename
	#$Extension
	#& .\ffmpeg.exe -i "$item" -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:a copy "$BaseName-1$Extension"
	#& .\ffmpeg.exe -i "$item" -y -vf "pad=if(gt(iw\, ih)\,-1\,min(ceil(iw/2)*2\,720)):if(gt(iw\, ih)\,min(ceil(ih/2)*2\,720)\,-1)" -c:a copy "$directoryname\$BaseName-1$Extension"
	#& .\ffmpeg.exe -i "$item" -y -vf "pad=if(lt(iw\,ih)\,-1\,min(ceil(iw/2)*2\,720)):if(lt(iw\,ih)\,min(ceil(ih/2)*2\,720)\,-1)" -c:a copy "$directoryname\$BaseName-1$Extension"
	#& .\ffmpeg.exe -i "$item" -y -vf "pad='if(gt(iw\,ih)\,-1:720\,720:-1)'" -c:a copy "$directoryname\$BaseName-1$Extension"
	#& .\ffmpeg.exe -i "$item" -vf "pad=min(ceil(iw/2)*2\,720):min(ceil(ih/2)*2\,720)" -c:a copy "$directoryname$BaseName-1$Extension"
	#& .\ffmpeg.exe -i "$item" -y -vf "pad='if(gt(iw\,ih),-4,720)':'if(gt(iw\,ih),720,-4)'" -c:a copy "$directoryname\$BaseName-1$Extension"
	#& .\ffmpeg.exe -i "$item" -vf "scale=-2:720,setsar=1:1" -c:a copy "$directoryname\$BaseName-1$Extension"