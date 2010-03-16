
#import <UIKit/UIKit.h>
#import "User.h"
@interface PhotoAppViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	IBOutlet UIImageView * imageView;
	IBOutlet UIButton * choosePhotoBtn;
	IBOutlet UIButton * takePhotoBtn;
	
	User *_user;

	UIImagePickerController * picker;
}

@property (nonatomic, retain) IBOutlet UIImageView * imageView;
@property (nonatomic, retain) IBOutlet UIButton * choosePhotoBtn;
@property (nonatomic, retain) IBOutlet UIButton * takePhotoBtn;
@property (nonatomic, retain) UIImagePickerController *picker;
@property (nonatomic, retain) User  *_user;

-(IBAction) getPhoto:(id) sender;
-(void)requestAction;
@end

