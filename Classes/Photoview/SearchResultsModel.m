#import "SearchResultsModel.h"
#import "BababianModel.h"
#import "XMLRPCExtensions.h"

SearchService CurrentSearchService = SearchServiceDefault;
SearchResponseFormat CurrentSearchResponseFormat = SearchResponseFormatDefault;

id<SearchResultsModel> CreateSearchModel(SearchService service, SearchResponseFormat responseFormat)
{
    id<SearchResultsModel> model = nil;
    switch ( service ) {
		case SearchServiceBababian:
		{
			NSLog(@"SEARCH SERVICE BABABIAN");
			model = [[[BababianModel alloc] initWithResponseFormat:responseFormat] autorelease];
			break;			
        }
		default:
            [NSException raise:@"CurrentSearchService unknown" format:nil];
            break;
    }
    return model;
}

id<SearchResultsModel> CreateSearchModelWithCurrentSettings(void)
{
    return CreateSearchModel(CurrentSearchService, CurrentSearchResponseFormat);
}