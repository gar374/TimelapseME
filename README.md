# TimelapseME

Introduction:
Timelapse Made Easy is an easy to use solution for non programmers to create timelapses using a raspberry pi
without having to figure out all the capture or rendering options.
You just have to start the script, answer a few questions and you're done!
###
Pre Requisites:
You'll need a raspberry pi (obviously) running raspbian
  A pi camera - all of my work has been carried out using a pi camera v2.1
  raspistill installed - sudo apt-get install raspistill
  libav-tool installed - for avconv to work - sudo apt-get install libav-tools
###
Installation:
Copy the timelapseme.sh file to your users home directory and run with ./TimelapseME.sh
###
Running:
From the location of the TimelapseME.sh file ./TimelapseME.sh
you'll then be prompted to enter the following :-

  How long do you want to capture images for (minutes)? 

  How many seconds between images? 

  What fps do you want to output you final movie at (eg 1-60)? 

  What output filename would you like to use (*.mp4)? 

**No error checking has been set up for the input paramaters**
A warning is displayed stating all previouse jpg files will be removed from the target directory
A summary of your selections is then displayed with an estimate of the final timelapse length for confirmation
A new subdirectory of the current directory the TimelapseME.sh file is in will be created if required
if the output file already exists, it will be deleted
any previous jpg files will be deleted
A capture/render logfile path will be displayed tail -f this if you want the detailed output from capture and render commands
Image capture will start
Image capture will complete and the number of captured images will be displayed
Sequencing will begin, this is just a renaming of the files in case there were issues during the capture
Sequencing will complete and the number of sequenced images will be displayed
Rendering will start
Rendering will complete and your output file will be listed
###
Example Run:
  Entering parameters:-
    Welcome to Timelapse Made Easy
    ------------------------------

  How long do you want to capture images for (minutes)? 1
  How many seconds between images? 1
  What fps do you want to output you final movie at (eg 1-60)? 11
  What output filename would you like to use (*.mp4)? test
  
  Running:-
    WARNING: All jpg files will be removed from /home/pi/timelapseme/ before starting this process!

    Timelapse to capture for 1 minute(s), at 1 second(s) between images, output at 11 fps.

    Your final movie will be approx 5 seconds, continue? (y|n)y

    Removing existing file test.mp4

    Detailed capture and rendering log can be see here /home/pi/timelapseme/capture-render.log

    Image capture started at 10:11:04
    Image capture complete at 10:12:06 for 52 images.

    Image sequencing started at 10:12:06
    Image sequencing complete at 10:12:07 for 52 images.

    Rendering started at 10:12:07
    Rendering complete at 10:13:20

    Your output file /home/pi/timelapseme/test.mp4 11.2163Mb
###
Constants:
  There are a number of constants that can be chaged within the script so it better meets you needs:-
    path=$HOME/timelapseme                #Specifies where the images and rendered file will be saved
    logfile="capture-render.log"          #Name of the logfile for output from rapistill and avconv commands
    file=1000000                          #Start number for sequencing, if you need more add an extra zero
    width=1920      #Not more than 3280   #Resolution set for 1080HD
    height=1080     #Not more than 2464   #Resolution set for 1080HD
###
Author:
Gareth M Hughes
###
License:
This script is license free with no copyright.  Please feel free to distribute, modify, update, change as required. 
Although an ackowledgement goes a long way.  Thanks

