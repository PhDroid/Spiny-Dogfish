//
//  Created by lynx on 12/4/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface SimpleStack : NSObject

-(void)push:(NSObject *)object;
-(NSObject *)pop;
@property ( nonatomic) int length;

@end