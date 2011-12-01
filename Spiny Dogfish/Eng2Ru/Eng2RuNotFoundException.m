//
//  Created by lynx on 11/30/11.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "Eng2RuNotFoundException.h"


@implementation Eng2RuNotFoundException {

}

+ (void)raise:(NSString *)message {
   [super raise:@"Eng2RuNotFoundException" format:message];
}
@end