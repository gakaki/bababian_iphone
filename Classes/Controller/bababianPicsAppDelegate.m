#import "bababianPicsAppDelegate.h"
#import "User.h"
#import "Photo.h"
#import "PhotoList.h"
#import "UserSet.h"
#import "Tag.h"
#import "LoginViewController.h"
#import "SearchPhotosViewController.h"
#import "Three20/Three20.h"
#import "Reachability.h"

@class Reachability;
@implementation bababianPicsAppDelegate

#pragma mark -
#pragma mark property
@synthesize window,self_email,self_pwd,loginViewController,user;
@synthesize tabBarController,navPhotoController,photoAppViewController;
@synthesize isUserPwdNullOrNil;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	[application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
//	//验证能联网吗
//	if (![[Reachability sharedReachability] isHostReachable:@"www.google.com"]) {
//		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"巴巴变" message:@"无法连接网络\r\n请检查您的网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]; 
//		[alert show];
//		[alert release];
//		return;
//	}
	
	
	// Allow HTTP response size to be unlimited.
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    
    // Configure the in-memory image cache to keep approximately
    // 10 images in memory, assuming that each picture's dimensions
    // are 320x480. Note that your images can have whatever dimensions
    // you want, I am just setting this to a reasonable value
    // since the default is unlimited.
    [[TTURLCache sharedCache] setMaxPixelCount:10*320*480];


	//[self ClearTheUserSettings];
	NSString *email = [[NSUserDefaults standardUserDefaults] stringForKey:EMAIL];
	NSString *pwd = [[NSUserDefaults standardUserDefaults] stringForKey:PWD];
	NSLog(@"email是%@,密码是%@",email,pwd);
	
	isUserPwdNullOrNil = NO;
	
	
	if(![User checkEmailNotNull:email andPwd:pwd]){
		[self flipLoginToFront];
		isUserPwdNullOrNil = YES;
		return;
	}
	if(![User isUserExists:email andPwd:pwd])
	{
		[self flipLoginToFront];
		isUserPwdNullOrNil = YES;
		return;
	}else{
		[self startTheProgram];
	}
		
	

}


-(void)startTheProgram{

	NSLog(@"继续执行");
	
	navPhotoController = [[UINavigationController alloc]initWithRootViewController:[[SearchPhotosViewController alloc] init]];
	
	photoAppViewController = [[PhotoAppViewController alloc] 
							  initWithNibName:@"PhotoAppViewController" bundle:nil];
	loginViewController = [[LoginViewController alloc] 
						   initWithNibName:@"LoginView" bundle:nil];
	tabBarController.viewControllers = [NSArray arrayWithObjects:
										navPhotoController,photoAppViewController,loginViewController	
										,nil];
	
	navPhotoController.tabBarItem.image = [UIImage imageNamed:@"popular.png"]; 	
	//photoAppViewController.title = @"photoviewcontroller";
	navPhotoController.tabBarItem.title = @"精彩推荐";
	photoAppViewController.tabBarItem.image = [UIImage imageNamed:@"camera.png"]; 	
	//photoAppViewController.title = @"photoviewcontroller";
	photoAppViewController.tabBarItem.title = @"上传照片";	
	///photoAppViewController.tabBarItem.badgeValue = @"1";
	//loginViewController.title = @"loginViewController";
	loginViewController.tabBarItem.title = @"设置";	
	loginViewController.tabBarItem.image = [UIImage imageNamed:@"settings.png"]; 
	
	[window addSubview:tabBarController.view];
	[window makeKeyAndVisible];

}




-(void)ClearTheUserSettings{

	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"email"];
	[[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"pwd"];
}

-(void)flipLoginToFront {
	
	LoginViewController* aLogin = [[LoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
	[self setLoginViewController:aLogin];
	[self.window addSubview:[aLogin view]];
	[aLogin.f1 becomeFirstResponder];
	[aLogin release];
}

// Flip Login screen back
-(void)flipLoginToBack {
	[loginViewController.view removeFromSuperview];
	[loginViewController release];
	loginViewController=nil;
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [tableViewDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if(cell == nil){
		cell = [[[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] 
				autorelease];
	}
	
	cell.textLabel.text = [tableViewDataArray objectAtIndex:indexPath.row];
	
	return cell;
}



- (void)dealloc {
	
	[tabBarController release];
	[loginViewController release];
	[photoAppViewController release];
	[navPhotoController release];
	
	[tableViewDataArray release];
    [window release];
    [super dealloc];
}

@end
