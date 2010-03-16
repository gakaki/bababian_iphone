
#import "PhotoAppViewController.h"
#import "User.h"
//#import "BaBaBianUploadRequest.h"
@implementation PhotoAppViewController
@synthesize imageView,choosePhotoBtn, takePhotoBtn;


-(IBAction) getPhoto:(id) sender {
	picker  = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	
	if((UIButton *) sender == choosePhotoBtn) {
		picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//or		picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	} else {
		picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	}
	
	[self presentModalViewController:picker animated:YES];
}

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	
	//check is the device can support the camera
	if(![UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)])
	{

		takePhotoBtn.enabled = FALSE;
		//takePhotoBtn.hidden = TRUE;
		[takePhotoBtn.titleLabel setText:@"不能拍"] ;
		takePhotoBtn.titleLabel.autoresizesSubviews =TRUE;
		//[takePhotoBtn.titleLabel setTextColor:[UIColor redColor] ];
		takePhotoBtn.titleLabel.adjustsFontSizeToFitWidth =TRUE;
			takePhotoBtn.titleLabel.textAlignment =UITextAlignmentCenter;

	}	else{
		[takePhotoBtn.titleLabel setText:@"拍照"] ;

	}
	
	NSLog(@"PhotoAppView is load");
	
	_user = [[User alloc] initWithDefaultPrefenences];
	[_user fetchSessionKey];
	NSLog(@"userkey is %@,userid is %@,session key is %@",_user.user_key,_user.userID,_user.session_key);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	[picker release];
	imageView.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];

	
	//add the button to view ,you could upload the photo
	
	UIButton* upload_btn = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
	upload_btn.frame = CGRectMake(choosePhotoBtn.frame.origin.x,choosePhotoBtn.frame.origin.y -60,
								  choosePhotoBtn.frame.size.width,
								  choosePhotoBtn.frame.size.height); 
//	upload_btn.backgroundColor = [UIColor blackColor];
	upload_btn.titleLabel.font = [UIFont boldSystemFontOfSize:30.0f]; 
	[upload_btn setTitle:@"上传" forState:UIControlStateNormal]; 
	[upload_btn addTarget:self action:@selector(upload_btnPressed:) forControlEvents:UIControlEventTouchUpInside]; 
	
	[self.view addSubview:upload_btn];

}
-(void)upload_btnPressed:(id)sender { 
	NSLog(@"开始上传图片");
	
	
	NSData *imageData = UIImagePNGRepresentation(imageView.image);
//	BaBaBianUploadRequest *request = [[BaBaBianUploadRequest alloc] 
//									  initWithUserName:@"gakaki" andPwd:@"z5896321"];
	[_user upload_photo:"图片描述" 
				   withPhoto:imageData 
					delegate:self  
			 requestSelector:@selector(requestAction:)];

}
-(void)requestAction{
	NSLog(@"上传完毕");
	
}
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_user release];
    [super dealloc];
}

@end
