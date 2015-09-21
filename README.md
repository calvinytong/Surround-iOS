# Surround-iOS
Multiview RTSP stream viewer built using the VLC SDK.

I had to remove MobileVLCKit to get this to commit because vlckit was to big. To put it back go to http://nightlies.videolan.org/build/ios/ and download MobileVLCKit-UniversalBinary-20150312-0555.zip. You may want to either mess with git ignore so it ignores the .framework file or migrate the project files to a different folder so you don't have to delete the frameework each time you commit. Unpack the ZIP file and place the .framework file into the folder with all of your project files. Finally, link the framework to your project by opening the project workspace, clicking on your project, navigating to build phases and linking the framework with your project in the link binaries with libraries tab. 
