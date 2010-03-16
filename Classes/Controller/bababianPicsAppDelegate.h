#import <UIKit/UIKit.h>
#import "XMLRPCResponse.h"
#import "XMLRPCRequest.h"
#import "XMLRPCConnection.h"
#import "LoginViewController.h"
#import "User.h"
#import "PhotoAppViewController.h"






#define EMAIL @"email"
#define PWD @"pwd"


@interface bababianPicsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	NSMutableArray *tableViewDataArray;


	User *user;

	NSString *self_email,*self_pwd;
	IBOutlet LoginViewController *loginViewController;
	IBOutlet UITabBarController *tabBarController;
	PhotoAppViewController *photoAppViewController;
	UINavigationController *navPhotoController;
	
	
	BOOL isUserPwdNullOrNil;
}
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSString *self_email,*self_pwd;
@property (nonatomic, retain) IBOutlet LoginViewController *loginViewController;
@property (nonatomic, retain) PhotoAppViewController *photoAppViewController;
@property (nonatomic, retain) UINavigationController *navPhotoController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic,assign) BOOL isUserPwdNullOrNil;

-(void)ClearTheUserSettings;
-(void)flipLoginToFront;
-(void)flipLoginToBack;
-(void)startTheProgram;


@end

