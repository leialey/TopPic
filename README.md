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
![Simulator Screen Shot - iPhone 6s - 2020-02-08 at 18 11 44_iphone7rosegold_portrait](https://user-images.githubusercontent.com/47685603/74084215-93507300-4a9f-11ea-8e62-9288e769fa23.png)
![Simulator Screen Shot - iPhone 6s - 2020-02-08 at 18 11 55_iphone7rosegold_portrait](https://user-images.githubusercontent.com/47685603/74084218-95b2cd00-4a9f-11ea-887b-2ee250b21fbe.png)
