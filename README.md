# Test Push Notification

This application receives notification from Firebase and store it in local storage.

## Installing Steps
1. Make sure your flutter version is up to date by running command `flutter upgrade`
2. In terminal at root project, run `flutter pub get` to get all packages.
3. Since Push Notification doesn't work on Simulator, then we need to run our application on real device. To do it you have to follow next steps:
	1. Open the Flutter project's Xcode target with
       open ios/Runner.xcworkspace
	2. Select the 'Runner' project in the navigator then the 'Runner' target
     in the project settings
	3. Make sure a 'Development Team' is selected under Signing & Capabilities > Team. 
     You may need to:
         - Log in with your Apple ID in Xcode first
         - Ensure you have a valid unique Bundle ID
         - Register your device with your Apple Developer Account
         - Let Xcode automatically provision a profile for your app
![enter image description here](https://i.postimg.cc/GtHfNrMS/Screenshot-2023-02-02-at-10-37-46.png)
4. Now you run project again 
