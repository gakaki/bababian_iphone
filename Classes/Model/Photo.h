#import <Foundation/Foundation.h>

@interface Photo : NSObject {
	NSString *did,*page_cur,*page_size;
}
@property (nonatomic, copy) NSString *did,*page_cur,*page_size;
	
-(id)initWithDid:(NSString *)anDid 
	  andPageCur:(NSString *)anPageCur 
	 andPageSize:(NSString *)anPageSize;
@end
