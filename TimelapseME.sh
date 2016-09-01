#Script to ask what timelapse settings you want and work out the number of frames and the length of the end video
#Written by Gareth M Hughes 29 Aug 2016#
########################################
path=$HOME/timelapseme                #Specifies where the images and rendered file will be saved
logfile="capture-render.log"          #Name of the logfile for output from rapistill and avconv commands
file=1000000                          #Start number for sequencing, if you need more add an extra zero
width=1920                            #Resolution set for 1080HD, don't set higher than 3280
height=1080                           #Resolution set for 1080HD, don't set higher that 2464
> $path/$logfile
clear
echo "Welcome to Timelapse Made Easy"
echo "------------------------------"
echo
echo -n "How long do you want to capture images for (minutes)? "
read minutes
echo -n "How many seconds between images? "
read freq
echo -n "What fps do you want to output you final movie at (eg 1-60)? "
read fps
echo -n "What output filename would you like to use (*.mp4)? "
read output
mseconds=$((minutes *60 *1000))
mfreq=$((freq *1000))
length=$((minutes * 60 / $freq / $fps))
clear
echo -n $(tput setaf 1)"WARNING:$(tput sgr0)"
echo " All jpg files will be removed from $path/ before starting this process!"
echo
echo "Timelapse to capture for $minutes minute(s), at $freq second(s) between images, output at $fps fps."
echo
read -p "Your final movie will be approx $length seconds, continue? (y|n)" -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
if [ ! -d $path ] 
then
        echo
        echo "$path doesn't exist, creating it now."
        mkdir -p $path
fi
if [ -f $path/$output.mp4 ]
then
        echo
        echo "Removing existing file $output.mp4"
        rm -f $path/$output.mp4
fi
rm -f $path/*.jpg
echo
echo "Detailed capture and rendering log can be see here $path/$logfile"
echo 
echo "Image capture started at `date|awk {'print $4'}`"
/usr/bin/raspistill -tl $mfreq -t $mseconds -w $width -h $height -q 10 -vf -hf -o $path/image%05d.jpg >>$path/$logfile 2>&1
echo "Image capture complete at `date|awk {'print $4'}` for `ls -ltr $path/image*.jpg|wc -l` images."
echo 
echo "Image sequencing started at `date|awk {'print $4'}`"
for filename in "$path"/*jpg
        do
        mv -- $filename $path/sequenced$file.jpg
        file=$(($file +1))
        done
echo "Image sequencing complete at `date|awk {'print $4'}` for `ls -ltr $path/sequenced*.jpg|wc -l` images."
echo
echo "Rendering started at `date|awk {'print $4'}`"
/usr/bin/avconv -n -r $fps -i $path/sequenced1%06d.jpg -r $fps -vcodec libx264 -crf $fps -g 15 $path/$output.mp4 >>$path/$logfile 2>&1
echo "Rendering complete at `date|awk {'print $4'}`"
echo
echo "Your output file `ls -ltr $path/$output.mp4|awk {'print $9" " $5/1024/1024"Mb"'}`"
echo
else 
echo "You chose to quit!"
fi
exit 0
