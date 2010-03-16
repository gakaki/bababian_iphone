#import <Foundation/Foundation.h>

@interface UserSet : NSObject {
	NSString *user_id,*page_cur,*page_size;
	NSMutableArray *user_sets;
}
@property (nonatomic, copy) NSString *user_id,*page_cur,*page_size;
@property (nonatomic, retain) NSMutableArray *user_sets;

-(id)initWithUserId:(NSString *)anUserId
		  andPageCur:(NSString *)anPageCur 
		 andPageSize:(NSString *)anPageSize;
	
@end
