
#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet UIButton * authorizeButton;
  	IBOutlet UITextField* f1;
	IBOutlet UITextField* f2;
}

-(void)textFieldLoginDidChange:(id)textField;
-(void)textFieldPasswordDidChange:(id)textField;
-(BOOL)textFieldShouldReturn:(UITextField *)textField;
-(IBAction)tellDelegateToFlipViews:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField* f1;
@property (nonatomic, retain) IBOutlet UITextField* f2;
@property (nonatomic, retain) IBOutlet UIButton* authorizeButton;

@end
