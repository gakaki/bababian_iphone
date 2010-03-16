

#import "Three20/Three20.h"

@interface SearchResult : NSObject
{
    NSString *title;
    NSString *bigImageURL;
    NSString *thumbnailURL;
    CGSize bigImageSize;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *bigImageURL;
@property (nonatomic, retain) NSString *thumbnailURL;
@property (nonatomic, assign) CGSize bigImageSize;

@end
