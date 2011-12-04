//
//  Created by lynx on 12/4/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SimpleStack.h"


@implementation SimpleStack
NSMutableArray *queue = [[NSMutableArray alloc] init];

-(void)push:(NSObject *)object{
    [queue addObject: object];  // adds at end
}

-(NSObject *)pop{
    NSObject *object = [queue objectAtIndex:0];  // take out the first one
    [queue removeObjectAtIndex:0];
    return object;
}

- (int)length {
    return sizeof(queue);
}

@end