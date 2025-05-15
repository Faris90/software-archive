#!/bin/sh
# Adium theme AdiumMessageStyle installer for Empathy
# Originally © 2009 Antono Vasiljev
# Licensed under the same terms as Empathy
# http://antono.info/en/165-install-adium-themes-to-empathy
# Changed by Vertlo Oraerk (did not work with directories containing spaces in the names)
# Changed by h!v from ubuntuforums to work with Pidgin+libwebkit and Notifications
# On Ubuntu you need to install libwebkit and libnotify-bin to get it working properly
# Further info on how to get working adium themes in Pidgin on http://www.webupd8.org/2009/05/pidgin-webkit-plugin-adium-conversation.html

if [ -z $1 ]
then
echo
echo "Usage:"
echo "`basename $0` adiumxtra://some.url.here/extra"
echo
exit 1
else
TMPDIR=`mktemp -d`
XTRAURL=`echo $1 | sed -e "s/^adiumxtra:/http:/"`
DEST="$HOME/.purple/message_styles/"


if [ ! -d $DEST ]
then
   mkdir -v -p $DEST
fi

cd $TMPDIR
notify-send "Downloading" \ "Adium theme for Pidgin" --icon=pidgin
wget --no-verbose -O xtra.zip $XTRAURL
unzip -qq xtra.zip

ls -d ./*.AdiumMessageStyle/ > themes_to_copy.lst
num_bytes=`wc -c themes_to_copy.lst | sed 's# themes_to_copy.lst##'`
NAME=`cat themes_to_copy.lst | cut -f 2 --delimiter='.' | cut -f 2 --delimiter='/'`

if [ $num_bytes = 0 ]
then
   notify-send "Sorry Manitou" \ "No themes found in downloaded file"
else
   while read line
   do
       echo cp -r \'$line\' "$DEST" | sh
   done < themes_to_copy.lst
   echo
   notify-send "Succesfully installed" \ " $NAME " --icon=pidgin
fi
rm -r xtra.zip
rm -r $TMPDIR
fi
exit 0
