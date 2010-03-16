

#import "Three20/Three20.h"

@protocol SearchResultsModel;

@interface SearchResultsPhotoSource : NSObject <TTPhotoSource>
{
    id<SearchResultsModel> *model;
    
    // Backing storage for TTPhotoSource properties.
    NSString *albumTitle;
    int totalNumberOfPhotos;    
}

- (id)initWithModel:(id<SearchResultsModel>)theModel;    // Designated initializer.

- (id<SearchResultsModel>)underlyingModel;     // The model to which this PhotoSource forwards in order to conform to the TTModel protocol.

@end
