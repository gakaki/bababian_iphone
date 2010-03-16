
#import "XMLRPCResponse.h"
#import "XMLRPCRequest.h"
#import "XMLRPCConnection.h"
#import "PhotoList.h"


@implementation PhotoList
	
@synthesize user_key,page_cur,page_size,photo_size;
@synthesize photos;

-(id)initWithUserKey:(NSString *)anUserKey
		  andPageCur:(NSString *)anPageCur 
		 andPageSize:(NSString *)anPageSize 
		andPhotoSize:(NSString *)anPhotoSize
{
	self = [super init]; 
	if (self) {
		
		NSString *server = @"http://www.bababian.com/xmlrpc";
		XMLRPCRequest *req_bind = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:server]];
		[req_bind setMethod:@"bababian.photo.getPhotoList" withObjects:
		 [NSArray arrayWithObjects:
		  Apikey,anUserKey,anPageCur,anPageSize,anPhotoSize,nil]];	
		XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req_bind];
		id *result=[userInfoResponse object];
		//NSLog(@"%@",result);
		[req_bind release];
		
		self.photos = [[[NSMutableArray alloc]init]retain];
		if ( [result isKindOfClass:[NSArray class]] ){
		
			for (NSDictionary *itea in result) {
				//NSLog(@"%@",itea);
				[photos addObject:itea];
			}
			
			NSLog(@"%d",[photos count]);
		}else{
			//NSLog(@"not nsarray");	
//		 	NSLog(@"%@",(NSDictionary *)result);
//			
//			NSDictionary *errors = (NSDictionary *)result;
//			NSString *key; 
//			for (key in errors) { 
//				NSLog(@"%@,%@", key, [errors valueForKey:key]); 
//			} 
//			[key release];
//			[errors release];	
		}
		//[result release];
	}
	
	return self; 
	
}





@end
