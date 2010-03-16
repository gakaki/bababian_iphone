#import "Three20/Three20.h"

@class SearchResultsPhotoSource;


@interface SearchPhotosViewController : TTViewController
{
    UITextField *queryField;
    SearchResultsPhotoSource *photoSource;
}

@end

