#import "BababianXMLRPCResponse.h"
#import "SearchResult.h"
#import "XMLRPCEncoder.h"
#import "XMLRPCDecoder.h"
#import "XMLRPCExtensions.h"
@implementation BababianXMLRPCResponse

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
	XMLRPCDecoder *decoder = [[[XMLRPCDecoder alloc] initWithData: data] autorelease];
	
	if (decoder == nil)
	{
		return nil;
	}
	id _object = [decoder decode];
	NSLog(@"decoder decode %@",_object);
	

	if ( [_object isKindOfClass:[NSArray class]] )
	{
		
		int num = 0;
		for (NSDictionary *rawResult in _object) {
			
			if(num==0){
			//	{
//					"page_cur" = 1;
//					"page_total" = 13;
//					"photo_total" = 241;
//				},
				NSLog(@"current num is %d and photototal is %@",num,[rawResult objectForKey:@"photo_total"]);
				totalObjectsAvailableOnServer = [[rawResult objectForKey:@"photo_total"] integerValue];
			}
			
			else{
			//NSString *mystring = @"http://photo2.bababian.com/upload3/20100312/517B2CB1974CA4B1407094308E495E24_100.jpg";
			NSString *bigImageURL = [[rawResult objectForKey:@"src"] stringByReplacingOccurrencesOfString:@"_100" withString:@""];
			NSLog(@"%@",bigImageURL);
			NSLog(@"bigImageURL retaincount is %i",[bigImageURL retainCount]);

			SearchResult *result = [[[SearchResult alloc] init] autorelease];
			result.bigImageURL = bigImageURL;
			result.thumbnailURL = [rawResult objectForKey:@"src"];
			result.title = [rawResult objectForKey:@"title"];
			result.bigImageSize = CGSizeMake([[rawResult objectForKey:@"600"] floatValue],
											 [[rawResult objectForKey:@"600"] floatValue]);
			
			[self.objects addObject:result];
			}
			num++;
			
		}
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
	
	//
//    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    
//    // Parse the JSON data that we retrieved from the server.
//    NSDictionary *json = [responseBody JSONValue];
//    [responseBody release];
//    
//    // Drill down into the JSON object to get the parts
//    // that we're actually interested in.
//    NSDictionary *root = [json objectForKey:@"photos"];
//    totalObjectsAvailableOnServer = [[root objectForKey:@"total"] integerValue];
//
//    // Now wrap the results from the server into a domain-specific object.
//    NSArray *results = [root objectForKey:@"photo"];
//    for (NSDictionary *rawResult in results) {
//        
//        SearchResult *result = [[[SearchResult alloc] init] autorelease];
//        result.bigImageURL = [rawResult objectForKey:@"url_m"];
//        result.thumbnailURL = [rawResult objectForKey:@"url_t"];
//        result.title = [rawResult objectForKey:@"title"];
//        result.bigImageSize = CGSizeMake([[rawResult objectForKey:@"width_m"] floatValue],
//                                         [[rawResult objectForKey:@"height_m"] floatValue]);
//
//        [self.objects addObject:result];
//    }
//    
    return nil;
}

- (NSString *)format { return @"json"; }

@end
