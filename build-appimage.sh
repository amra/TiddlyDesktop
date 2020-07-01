#!/bin/bash

ZIP=/tmp/tiddlydesktop-linux64-v0.0.14.zip

if [ ! -s $ZIP ]
then
	wget -O /tmp/tiddlydesktop-linux64-v0.0.14.zip https://github.com/Jermolene/TiddlyDesktop/releases/download/v0.0.14/tiddlydesktop-linux64-v0.0.14.zip
fi

unzip -q $ZIP -d /tmp

APP=/tmp/TiddlyDesktop.AppDir
mkdir -p $APP
rm $APP/* -rf
mv /tmp/TiddlyDesktop-linux64-v0.0.14/* $APP
cp $APP/images/app-icon.png $APP/TiddlyDesktop.png
cat <<EOF >$APP/TiddlyDesktop.desktop
[Desktop Entry]
Name=TiddlyDesktop
Exec=nw
Icon=TiddlyDesktop
Type=Application
Categories=Utility;TextEditor;
EOF

#cat <<EOF >$APP/AppRun
#!/bin/bash
#./nw
#EOF
cp $APP/nw $APP/AppRun
chmod +x $APP/AppRun

if [ ! -s ~/bin/appimagetool-x86_64.AppImage ]
then
	wget -O ~/bin/appimagetool-x86_64.AppImage https://github.com/AppImage/AppImageKit/releases/download/12/appimagetool-x86_64.AppImage
	chmod +x ~/bin/appimagetool-x86_64.AppImage
fi

ARCH=x86_64 appimagetool-x86_64.AppImage /tmp/TiddlyDesktop.AppDir/ /tmp/TiddlyDesktop.AppImage

