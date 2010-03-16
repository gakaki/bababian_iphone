

#import "Three20/Three20.h"


@interface URLModelResponse : NSObject <TTURLResponse>
{
    NSMutableArray *objects;
    NSUInteger totalObjectsAvailableOnServer;
}

@property (nonatomic, retain) NSMutableArray *objects; // Intended to be read-only for clients, read-write for sub-classes
@property (nonatomic, readonly) NSUInteger totalObjectsAvailableOnServer;

+ (id)response;
- (NSString *)format;

@end
