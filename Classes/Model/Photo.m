#import "XMLRPCResponse.h"
#import "XMLRPCRequest.h"
#import "XMLRPCConnection.h"
#import "Photo.h"

@implementation Photo


@synthesize did,page_cur,page_size;

-(id)initWithDid:(NSString *)anDid 
	  andPageCur:(NSString *)anPageCur 
	 andPageSize:(NSString *)anPageSize
{
	self = [super init]; 
	if (self) {
		NSString *server = @"http://www.bababian.com/xmlrpc";
		XMLRPCRequest *req_bind = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:server]];
		[req_bind setMethod:@"bababian.photo.getPhotoInfo" withObjects:
		 [NSArray arrayWithObjects:
		  Apikey,anDid,anPageCur,anPageSize,nil]];	
		XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req_bind];
		id *result=[userInfoResponse object];
		//NSLog(@"%@",result);
		[req_bind release];
		
		//user_key(String)：	用于用户绑定的key值，代表一个唯一的用户。
		//		//NSLog([result isKindOfClass:[NSArray class]]);return;
		if ( [result isKindOfClass:[NSArray class]] ){
	
		}else{
			NSDictionary *errors = (NSDictionary *)result;
			NSString *key; 
			for (key in errors) { 
			//	NSLog(@"%@,%@", key, [errors valueForKey:key]); 
			} 
			[key release];
			[errors release];
			
		}
		//[result release];
	}
	
	return self; 
	
}
@end
