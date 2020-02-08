TopPic is a simple app fetching a list of popular images and their titles sorted by popularity from the Imgur APIs in infinite scroll. You can also check image's top comments. 

Technology stack:

- Alamofire
- SwiftyJSON
- AlamofireImage
- Bond
- SVProgressHUD

The app is designed in MVVM way with reactive bindings between the view models and the views using Swift Bond. 

You need to register your user and application on Imgur: 
https://imgur.com/

Add your application's generated Client ID to apiAuth.plist found in Supporting files folder.

	<key>client-id</key>
	<string>yourClientID</string>
