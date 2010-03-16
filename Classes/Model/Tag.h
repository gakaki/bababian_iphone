
#import <Foundation/Foundation.h>


@interface Tag : NSObject {
	NSString *tag;
	int count;
}

@property (nonatomic, copy) NSString *tag;
@property (nonatomic, readwrite) int count;

-(id)initWithUserId:(NSString *)anUserId;
		

@end