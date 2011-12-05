//
//  Created by lynx on 12/5/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Eng2RuParsingException.h"


@implementation Eng2RuParsingException {

}

+ (void)raise:(NSString *)string{
    [super raise:@"Eng2RuParsingException" format:string];
}

@end