
# Table of Contents

1.  [Convert audio files to mp3s with ffmpeg](#org52f4ee8)
    1.  [Problem description](#org1562da1)
        1.  [Previous attempts](#orgd5ce553)



<a id="org52f4ee8"></a>

# Convert audio files to mp3s with ffmpeg


<a id="org1562da1"></a>

## Problem description

<https://unix.stackexchange.com/questions/114908/bash-script-to-convert-all-flac-to-mp3-with-ffmpeg>

    #!/bin/bash
    
    # Copy this file into directory with flac files and run it with 
    # bash flac2mp3.sh
    
    for i in *.flac ; do 
        ffmpeg -i "$i" -acodec libmp3lame -ab 320k "$(basename "${i/.flac}")".mp3
        # sleep 60
    done


<a id="orgd5ce553"></a>

### Previous attempts

    
    # # Check if ffmpeg is installed
    # if ! command -v ffmpeg &> /dev/null; then
    #     echo "ffmpeg is not installed. Please install ffmpeg first."
    #     exit 1
    # fi
    # 
    # # Check if the input folder is provided as an argument
    # if [ $# -eq 0 ]; then
    #     echo "Usage: $0 <input_folder> <output_quality>"
    #     exit 1
    # fi
    # 
    # input_folder=$1
    # output_quality=$2
    # 
    # # Check if the input folder exists
    # if [ ! -d "$input_folder" ]; then
    #     echo "Input folder not found."
    #     exit 1
    # fi
    # 
    # # Convert all FLAC files to MP3 with the specified quality
    # find "$input_folder" -type f -name "*.flac" | while read file; do
    #     sleep 1s
    #     echo "$file"
    #     output_file=$(echo "$file" | sed 's/\.flac$/.mp3/')
    #     echo "$output_file"
    #     cmmd="ffmpeg -i \"${file}\" -ab ${output_quality} \"${output_file}\""
    #     echo $cmmd
    #     # eval $cmmd
    # #     eval echo eval "$cmmd"
    #     # echo $("fmpeg" "-i" "${file}" "-ab" "$output_quality" "$output_file")
    #     ffmpeg -i """$file""" -ab """$output_quality""" """$output_file"""
    # done
    # 
    # echo "Conversion completed." 
    # 
    
    
    
    # format = flac
    # BITRATE = 320
    # 
    # echo $format 
    # 
    # find -name "*.${format}" -exec bash -c 'ffmpeg -i "{}" -y -vsync 0 -c:v copy -acodec libmp3lame -ab '${BITRATE}'k "${0/.'${format}'}.mp3"' {} \;

