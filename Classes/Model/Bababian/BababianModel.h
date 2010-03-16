
#import "Three20/Three20.h"
#import "SearchResultsModel.h"

@class URLModelResponse;
@interface BababianModel : TTURLRequestModel <SearchResultsModel>
{
    URLModelResponse *responseProcessor;
    NSString *searchTerms;
    NSUInteger page;
}


@end
