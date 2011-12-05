//
//  Created by lynx on 12/4/11.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "SimpleStack.h"


@implementation SimpleStack
NSMutableArray *queue;
@synthesize length;

-(id)init{
    id result = [super init];
    queue = [[NSMutableArray alloc]init];
    length = 0;
    return result;
}

-(void)push:(NSObject *)object{
    [queue addObject: object];  // adds at end
    length++;
}

-(NSObject *)pop{
    NSObject *object = [queue objectAtIndex:0];  // take out the first one
    [queue removeObjectAtIndex:0];
    length--;
    return object;
}

@end