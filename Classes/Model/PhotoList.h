
#import <Foundation/Foundation.h>

@interface PhotoList : NSObject {
	NSString *user_key,*page_cur,*page_size,*photo_size;
	NSMutableArray *photos;
}
@property (nonatomic, copy) NSString *user_key,*page_cur,*page_size,*photo_size;
@property (nonatomic, retain) NSMutableArray *photos;

-(id)initWithUserKey:(NSString *)anUserKey
	  andPageCur:(NSString *)anPageCur 
	 andPageSize:(NSString *)anPageSize 
	 andPhotoSize:(NSString *)anPhotoSize;


/*
 api_key(String)：	由巴巴变提供的参数。
 user_key(String)：	用户绑定的key值，代表一个唯一的用户。
 page_cur(String)：	当前要显示的页。
 page_size(String)：	分页显示时，每页显示的照片数。(目前提供每页显示10—20张照片)
 photo_size(String)：所要显示的照片的大小。(目前提供照片的尺寸是75、100、240)
 */
@end
