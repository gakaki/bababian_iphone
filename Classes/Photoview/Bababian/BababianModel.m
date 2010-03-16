#import "BababianModel.h"
#import "BababianXMLRPCResponse.h"

#import "XMLRPCEncoder.h"
#import "XMLRPCExtensions.h"
const static NSUInteger kFlickrBatchSize = 16;   // The number of results to pull down with each request to the server.

@implementation BababianModel

@synthesize searchTerms;

- (id)initWithResponseFormat:(SearchResponseFormat)responseFormat;
{
    if ((self = [super init])) {
        switch ( responseFormat ) {
            case SearchResponseFormatXMLRPC:
			{
				NSLog(@"this is xmlrpc");
                responseProcessor = [[BababianXMLRPCResponse alloc] init];
                break;
            }
			case SearchResponseFormatXML:
			{
				
                responseProcessor = [[BababianXMLRPCResponse alloc] init];
                break;
            }
			default:
                [NSException raise:@"SearchResponseFormat unknown!" format:nil];
        }
        page = 1;
    }
		NSLog(@"initWithResponseFormat:CurrentSearchResponseFormat start");
    return self;
}

- (id)init
{
	NSLog(@"init:CurrentSearchResponseFormat start");
    return [self initWithResponseFormat:CurrentSearchResponseFormat];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
	NSLog(@"SEE the secnod chace is load?!!!!!!!!!!");
    NSLog(@"(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more");
    if (more)
		page++;
    else
        [responseProcessor.objects removeAllObjects]; // Clear out data from previous request.

	NSLog(@"responseProcessor.objects removeAllObjects error");

	NSString *Apikey = @"57456DDAAADB1031C9D4431FB3886540AK";

	//NSString *page_string = [(NSString*)page copy];
	
	NSString *page_num = [NSString stringWithFormat:@"%d", page];
	NSLog(@"current page is %@",page_num);
	XMLRPCEncoder *rpcencoder = [[XMLRPCEncoder alloc]init];
	[rpcencoder setMethod:@"bababian.photo.getRecommendPhoto" 
			  withObjects:[NSArray arrayWithObjects:
						   Apikey,page_num,@"16",@"100",nil]];		
	
	//NSLog(@"no error with encodemethod %d",page_string);

	NSString *encodeString = [rpcencoder encode];
	NSData *rpc_data = [encodeString dataUsingEncoding: NSUTF8StringEncoding];
	NSString *length = [[NSNumber numberWithInt: [rpc_data length]] stringValue];
	NSLog(@"LENGTH IS %@",length);
	[rpcencoder release];

	
//	
//    		//NSString *version  = [[[NSBundle mainBundle] infoDictionary] valueForKey:[NSString stringWithFormat:@"CFBundleVersion"]];
//	
	NSMutableDictionary* _headers = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								  @"iphone_bababian/%@qq82506111", @"User-Agent",
								  @"text/xml", @"Content-Type",
								  length, @"Content-Length",
								  nil];
//	// Construct the request.
    NSString *host = @"http://www.bababian.com/xmlrpc";
	
    TTURLRequest *request = [TTURLRequest requestWithURL:host delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = responseProcessor;
    request.httpMethod = @"POST";
	request.httpBody = rpc_data;
	request.headers = _headers;
//
//    // Dispatch the request.
    [request send];
//	[host release];
//	[length release];
}

- (void)reset
{
    [super reset];
    [searchTerms release];
    searchTerms = nil;
    page = 1;
    [[responseProcessor objects] removeAllObjects];
}

- (void)setSearchTerms:(NSString *)theSearchTerms
{
	NSLog(@"入口点");
    //if (![theSearchTerms isEqualToString:searchTerms]) {
//        [searchTerms release];
//        searchTerms = [theSearchTerms retain];
//        page = 1;
//    }
	page =1;
}

- (NSArray *)results
{
    return [[[responseProcessor objects] copy] autorelease];
}

- (NSUInteger)totalResultsAvailableOnServer
{
    return [responseProcessor totalObjectsAvailableOnServer];
}

- (void)dealloc
{
    [searchTerms release];
    [responseProcessor release];
    [super dealloc];
}

@end
