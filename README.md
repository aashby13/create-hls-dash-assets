## Install ffmpeg macOS

* Download ffmpeg zipped static binary: https://evermeet.cx/ffmpeg/

* If other OS look here: https://ffmpeg.org/download.html

* Extract ffmpeg Zip Double Click on Archive in Finder

* Open Terminal or other command line tool
  >`$ cd && cd Downloads`

* Remove zip
  >`$ rm ./ffmpeg*.zip`

* Make opt directory in /usr/local/ (if you use Homebrew, the directory may already exist)
  >`$ sudo mkdir /usr/local/opt`

* Relocate ffmpeg
  >`$ sudo mv ./ffmpeg* /usr/local/opt/ffmpeg`

* May need to set SuperUser as owner
  >`$ sudo chown -R root:admin /usr/local/opt/ffmpeg`

* Insert ffmpeg into User’s Path (.zshrc, .profile, bash_profile, etc.)
  >`$ nano $HOME/.zshrc`

* Add Append
  >`$ export PATH=$PATH:/usr/local/opt/ffmpeg/bin`

* Reload the Path with:
  >`$ source $HOME/.zshrc`

* Test ffmpeg Setup
  >`$ ffmpeg --help`



## Install bento4

* Download bento4: https://www.bento4.com/downloads/

* Follow same instructions for ffmpeg
  >`$ rm ./Bento4*.zip`

    >`$ sudo mv ./Bento4* /usr/local/opt/bento4`
  
    > `...`

* Test for bento4
  >`$ mp4dash --help`

* If you have issues with macOS security
  >`$ sudo xattr -d com.apple.quarantine /usr/local/opt/bento4/bin/*`


## Install fswatch

* MacPorts
  >`$ port install fswatch`

* Homebrew
  >`$ brew install fswatch`

* Or see instuctions to build from source @ https://github.com/emcrisostomo/fswatch


## How To Use

* Place hls_dash.sh in directory with videos to process, nav to directory and run script
  >`$ ./hls_dash.sh`

* To have mp4s proceesed when they are added to directory, add watch.sh and hls_dash.sh to directory and run watch script
  >`$ ./watch.sh`
