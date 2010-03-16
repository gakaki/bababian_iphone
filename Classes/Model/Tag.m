#import "Tag.h"
#import "XMLRPCResponse.h"
#import "XMLRPCRequest.h"
#import "XMLRPCConnection.h"

@implementation Tag

@synthesize  tag,count;

-(id)initWithUserId:(NSString *)anUserId{

	self = [super init]; 
	if (self) {
		
		NSString *server = @"http://www.bababian.com/xmlrpc";
		XMLRPCRequest *req_bind = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:server]];
		[req_bind setMethod:@"bababian.tag.getUserTagList" withObjects:
		 [NSArray arrayWithObjects:
		  Apikey,anUserId,nil]];	
		XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req_bind];
		id *result=[userInfoResponse object];
		NSLog(@"tag 的 结果为 %@",result);
		[req_bind release];
		

		if ( [result isKindOfClass:[NSArray class]] ){
			
			for (NSDictionary *itea in result) {
				NSLog(@"%@",itea);
						}
			
		}else{
			NSLog(@"not nsarray");	
						NSDictionary *errors = (NSDictionary *)result;
						NSString *key; 
					for (key in errors) { 
						NSLog(@"%@,%@", key, [errors valueForKey:key]); 
						} 
						[key release];
						//[errors release];	
		}
		//[result release];
	}
	
	return self; 

}



@end
