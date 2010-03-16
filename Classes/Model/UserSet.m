#import "XMLRPCResponse.h"
#import "XMLRPCRequest.h"
#import "XMLRPCConnection.h"
#import "UserSet.h"


@implementation UserSet

@synthesize user_id,page_cur,page_size;
@synthesize user_sets;

-(id)initWithUserId:(NSString *)anUserId
		 andPageCur:(NSString *)anPageCur 
		andPageSize:(NSString *)anPageSize
{
	self = [super init]; 
	if (self) {
		
		NSString *server = @"http://www.bababian.com/xmlrpc";
		XMLRPCRequest *req_bind = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:server]];
		[req_bind setMethod:@"bababian.set.getSetList" withObjects:
		 [NSArray arrayWithObjects:
		  Apikey,anUserId,anPageCur,anPageSize,nil]];	
		XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req_bind];
		id *result=[userInfoResponse object];
		NSLog(@"Userset 的数据%@",result);
		[req_bind release];
		
		user_sets = [[[NSMutableArray alloc]init]retain];
	
		if ( [result isKindOfClass:[NSArray class]] ){
			
			for (NSDictionary *itea in result) {
				//NSLog(@"%@",itea);
				[user_sets addObject:itea];
			}
			
			NSLog(@"user_sets 的数据 %d",[user_sets count]);
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
