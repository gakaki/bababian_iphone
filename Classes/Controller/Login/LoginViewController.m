#import "LoginViewController.h"
#import "bababianPicsAppDelegate.h"
#import "User.h"

@implementation LoginViewController

@synthesize f1, f2;
@synthesize authorizeButton;

- (void)viewDidLoad {

    [super viewDidLoad];
	
	//self.f1.delegate = self;
	//self.f2.delegate = self;

	
	//	[self.authorizeButton setBackgroundImage:[[UIImage imageNamed:@"startbtn.png"] stretchableImageWithLeftCapWidth:8.0 topCapHeight:0.0 ] forState:UIControlStateNormal];
//
//    UIColor* myBlue = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:132.0/255.0 alpha:0.75];
//
	f1.text = [[NSUserDefaults standardUserDefaults] stringForKey:k2emailKey2];
	f2.text = [[NSUserDefaults standardUserDefaults] stringForKey:k2passwordKey2];
//
//	[f1 setTextColor:myBlue];
//	[f2 setTextColor:myBlue];
//	

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldLoginDidChange:) name:@"UITextFieldTextDidChangeNotification" object:f1];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldPasswordDidChange:) name:@"UITextFieldTextDidChangeNotification" object:f2];

	[f2 setSecureTextEntry:YES];
	[f1 becomeFirstResponder];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  	[textField resignFirstResponder];
	
	NSUserDefaults *standardUserDefaults = (NSUserDefaults *)[NSUserDefaults standardUserDefaults];
	
	if (textField.secureTextEntry) {
		// Set password
		[standardUserDefaults setObject:textField.text forKey:k2passwordKey2];
	} else {
		// Set login
		[standardUserDefaults setObject:textField.text forKey:k2emailKey2];
	}
	
	return YES;
}	
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
}

-(void)textFieldLoginDidChange:(id)textField {	

	NSMutableString* strLogin = (NSMutableString*)[[textField object] text];
	NSUserDefaults *standardUserDefaults = (NSUserDefaults *)[NSUserDefaults standardUserDefaults];
	[standardUserDefaults setObject:strLogin forKey:k2emailKey2];
	NSLog(@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:k2emailKey2]);
	
}

-(void)textFieldPasswordDidChange:(id)textField {	
	NSMutableString* strPassword = (NSMutableString*)[[textField object] text];
	NSUserDefaults *standardUserDefaults = (NSUserDefaults *)[NSUserDefaults standardUserDefaults];
	[standardUserDefaults setObject:strPassword forKey:k2passwordKey2];
	NSLog(@"%@",[[NSUserDefaults standardUserDefaults]stringForKey:k2passwordKey2]);
} 

-(IBAction)tellDelegateToFlipViews:(id)sender {

	bababianPicsAppDelegate* myApp = (bababianPicsAppDelegate*)[[UIApplication sharedApplication] delegate];
	
	
	if([User isUserExists:[[NSUserDefaults standardUserDefaults] stringForKey:k2emailKey2] 
				   andPwd:[[NSUserDefaults standardUserDefaults] stringForKey:k2passwordKey2]]){
		NSLog(@"yes");
		
		NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
		[standardUserDefaults synchronize];
		
		// Lose the login screen
		[f1 resignFirstResponder];
		[f2 resignFirstResponder];
		if(myApp.isUserPwdNullOrNil == YES)
		{
			[myApp flipLoginToBack];
			[myApp startTheProgram];
			
		}
		
		
		
	}
	else{
		NSLog(@"no");
		
		
				
	}
		
}
- (void)dealloc {
	[authorizeButton release];
	[f1 release];
	[f2 release];	

    [super dealloc];
}


@end
