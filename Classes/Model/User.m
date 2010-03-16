#import "User.h"
#import "XMLRPCResponse.h"
#import "XMLRPCRequest.h"
#import "XMLRPCConnection.h"
#import "XMLRPCEncoder.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation User

@synthesize email,password,user_key,userID,session_key,cap_total,cap_used,error_string,isBind;
@synthesize receivedData,receivedData,delegate,callback,errorCallback,credentialCallback;
@synthesize alert,indicator;

-(void)upload_photo:(NSString *)status withPhoto:(NSData*)photoData delegate:(id)requestDelegate requestSelector:(SEL)requestSelector;{
	
	

	
	//first get the session key
	[self fetchSessionKey];

	
	alert = [[[UIAlertView alloc] initWithTitle:@"正在上传请等待..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
	[alert show];
	indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	// Adjust the indicator so it is up a few pixels from the bottom of the alert
	indicator.center = CGPointMake(alert.bounds.size.width / 2, alert.bounds.size.height - 50);
	[indicator startAnimating];
	[alert addSubview:indicator];
	[indicator release];
	
	
	
	
	
	isPost = YES;
	// Set the delegate and selector
	self.delegate = requestDelegate;
	self.callback = requestSelector;
	// The URL of the Twitter Request we intend to send
	NSURL *url = [NSURL URLWithString:@"http://www.bababian.com/upload"];	
	
	// Now, set up the post data:
	request = [[[ASIFormDataRequest alloc] initWithURL:url] autorelease];
	[request setDelegate:self];
	
	[request setData:photoData forKey:@"file"];
	[request setPostValue:@"pho" forKey:@"file_type"];
	[request setPostValue:self.user_key forKey:@"user_key"];
	[request setPostValue:self.session_key forKey:@"session_key"];
	
	
	
	
	// Initiate the WebService request
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	
	NSLog(@"requestFinished %@", [request responseString]);
	
	NSString *title = nil;
	NSScanner *scanner = [NSScanner scannerWithString:[request responseString]];
	[scanner scanUpToString:@"<title>" intoString:nil];
	[scanner scanString:@"<title>" intoString:nil];
	[scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"<"] intoString:&title];
	
	NSLog(@"title is %@", title);
	
	
	
	
	[alert dismissWithClickedButtonIndex:0 animated:YES];

	
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"巴巴变" message:title delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]; 
	[alert show];
	[alert release];
	
	
	
	
	
	//
//	NSPredicate * regexTest = [NSPredicate predicateWithFormat: @"SELF MATCHES '成功'"];
//	if ([regexTest evaluateWithObject: title] == YES) {
//		NSLog(@"yes upload ok");
//	}
//	else{
//		NSLog(@"no fail");
//	}
	
	// do something with the data
	
	if(delegate && callback) {
		if([delegate respondsToSelector:self.callback]) {
			[delegate performSelector:self.callback withObject:receivedData];
		} else {
			NSLog(@"No response from delegate");
		}
	} 
	
	// release the connection, and the data object
	//[request release];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	
	NSError *error = [request error];
}



+(BOOL)checkEmailNotNull:(NSString *)anEmail andPwd:(NSString *)anPwd{
	if([anEmail length] == 0 || [anPwd length]== 0){
		return NO;
	}else{
		return YES;
	}
}
+(BOOL)isUserExists:(NSString *)anEmail andPwd:(NSString *)anPwd;{
	

	XMLRPCEncoder *rpcencoder = [[XMLRPCEncoder alloc]init];
	[rpcencoder setMethod:@"bababian.user.bind" withObjects:[NSArray arrayWithObjects:
															 Apikey,anEmail,anPwd,nil]];	
	//NSLog(@"RPCENCODE method is %@",[rpcencoder method]);
	NSLog(@"RPCENCODE source is %@",[rpcencoder source]);
	[rpcencoder release];
	
	
	if([anEmail length] == 0 || [anPwd length]== 0){
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"巴巴变" message:@"请填写用户名或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]; 
		[alert show];
		[alert release];
		return NO;
	}
	
	XMLRPCRequest *req_bind = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:ApiAddress]];
	[req_bind setMethod:@"bababian.user.bind" withObjects:[NSArray arrayWithObjects:
														   Apikey,anEmail,anPwd,nil]];	
	XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req_bind];
//	
//	
//	NSDictionary *errors = (NSDictionary *)[userInfoResponse object];
//	NSString *key; 
//	for (key in errors) { 
//		NSLog(@"%@,%@", key, [errors valueForKey:key]); 
//	} 
//	[key release];
//	[errors release];
//	
	id *result = [userInfoResponse object];
	if ([result isKindOfClass:[NSArray class]]){
		
		NSLog(@"userInfoResponse retiancount is %d",[userInfoResponse retainCount]);
		NSLog(@"req_bind retiancount is %d",[req_bind retainCount]);
		NSLog(@"anPwd retiancount is %d",[anPwd retainCount]);
		NSLog(@"anEmail retiancount is %d",[anEmail retainCount]);
	
		
		
		return YES;
	}else{

		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"巴巴变" 
													   message:[(NSDictionary *)result valueForKey:@"faultString"] 
													   delegate:self 
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil]; 
		[alert show];
		[alert release];
	
		NSLog(@"userInfoResponse retiancount is %d",[userInfoResponse retainCount]);
		NSLog(@"req_bind retiancount is %d",[req_bind retainCount]);
		NSLog(@"anPwd retiancount is %d",[anPwd retainCount]);
		NSLog(@"anEmail retiancount is %d",[anEmail retainCount]);
		NSLog(@"result retiancount is %d",[result retainCount]);

		
		return NO;
	}

}
-(NSString *)fetchSessionKey{

	NSString *server = @"http://www.bababian.com/xmlrpc";
	XMLRPCRequest *req_bind = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:server]];
	[req_bind setMethod:@"bababian.photo.uploadSession" withObjects:
	 [NSArray arrayWithObjects:
	  Apikey,user_key,nil]];	
	XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req_bind];
	id *result=[userInfoResponse object];
	NSLog(@"%@",result);
	
	
	if ( [result isKindOfClass:[NSArray class]] ){
		//			NSLog(@"is nsarray");	
		
		session_key = [result objectAtIndex:0];
		cap_total = [result objectAtIndex:1];
		cap_used = [result objectAtIndex:2];
		NSLog(@"当前session key 为%@,每月的总空间%@ M容量,当前月份已经使用的空间为%@ M"
			   ,session_key,cap_total,cap_used
		);
			
	}else{
		NSDictionary *errors = (NSDictionary *)result;
		NSString *key; 
		for (key in errors) { 
			NSLog(@"api upload session key error %@,%@", key, [errors valueForKey:key]); 
		} 
		[key release];
		[errors release];
	}
	//[result release];
	//[req_bind release];
	return [session_key copy];
}
-(id)initWithDefaultPrefenences{
	
	NSString *defaultEmail = [[NSUserDefaults standardUserDefaults] stringForKey:k2emailKey2];
	NSString *defaultPwd = [[NSUserDefaults standardUserDefaults] stringForKey:k2passwordKey2];
	
	defaultEmail = @"gakaki@gmail.com";
	defaultPwd = @"z5896321";
	
	return [self initWithEmail:defaultEmail andPwd:defaultPwd];
}
-(id)initWithEmail:(NSString *)anEmail andPwd:(NSString *)anPwd{
	self = [super init]; 
	if (self) {
	
		XMLRPCRequest *req_bind = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:ApiAddress]];
		[req_bind setMethod:@"bababian.user.bind" withObjects:[NSArray arrayWithObjects:
		  Apikey,anEmail,anPwd,nil]];	
	
		XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req_bind];
		id *result=[userInfoResponse object];
		
		//NSLog(@"%@",result);
		
		if ( [result isKindOfClass:[NSArray class]] ){
//			NSLog(@"is nsarray");	
			user_key = (NSString *)[result objectAtIndex:0];
			userID = (NSString *)[result objectAtIndex:1];
			email = anEmail;
			password = anPwd;	
			isBind =YES;
		}else{
		
		 	NSLog(@"%@",(NSDictionary *)result);
			
		//	NSDictionary *errors = (NSDictionary *)result;
//			NSString *key; 
//			for (key in errors) { 
//				self.error_string = @"出错";
//				//NSLog(@"%@,%@", key, [errors valueForKey:key]); 
//			} 
//			isBind = NO;
//			[key release];
//			[errors release];

		}
		
		//[result release];
//		[req_bind release];
//		
	}
	
	return self; 
	
}

- (void)dealloc {
	[alert release];
	[indicator release];
	
	[email release];
	[password release];
	[user_key release];
	[userID release];
	[session_key release];
	[cap_total release];
	[cap_used release];
	[error_string release];
	[isBind release];
	[receivedData release];
	[delegate release];
	[callback release];
	[errorCallback release];
	[credentialCallback release];
	

	
    [super dealloc];
}

@end
