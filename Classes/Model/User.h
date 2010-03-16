#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"

#define k2emailKey2		@"email"
#define k2passwordKey2	@"pwd"

@protocol returnString<NSObject>
-(NSString *)returnString;
@end

@interface User : NSObject<returnString> {

	NSString *email,*password,*user_key,*userID,*session_key,*cap_total,*cap_used
	,*error_string;
	BOOL isBind;



	NSMutableData		*receivedData;
	NSMutableURLRequest	*theRequest;
	NSURLConnection		*theConnection;
	id					delegate;
	SEL					callback;
	SEL					errorCallback;
	SEL					credentialCallback;
	
	BOOL				isPost;
	NSString			*requestBody;
	ASIFormDataRequest  *request;
	
	
	
	
		UIAlertView *alert;
	UIActivityIndicatorView *indicator;
}
@property(nonatomic) UIAlertView *alert;
@property(nonatomic) UIActivityIndicatorView *indicator;

@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, retain) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					errorCallback;
@property(nonatomic) SEL					credentialCallback;




-(void)upload_photo:(NSString *)status withPhoto:(NSData*)photoData delegate:(id)requestDelegate requestSelector:(SEL)requestSelector;


@property (nonatomic, retain) NSString *email,*password,*user_key,*userID,*session_key,*cap_total,*cap_used,*error_string;
@property (nonatomic) BOOL isBind;

-(id)initWithDefaultPrefenences;
-(id)initWithEmail:(NSString *)anEmail andPwd:(NSString *)anPwd;
+(BOOL)isUserExists:(NSString *)anEmail andPwd:(NSString *)anPwd;
+(BOOL)checkEmailNotNull:(NSString *)anEmail andPwd:(NSString *)anPwd;
-(NSString *)fetchSessionKey;
-(void)requestFinished:(ASIHTTPRequest *)request;

@end
