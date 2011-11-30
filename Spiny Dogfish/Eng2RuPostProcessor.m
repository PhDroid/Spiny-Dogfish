//
//  Created by lynx on 12/1/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Eng2RuPostProcessor.h"


@implementation Eng2RuPostProcessor
-(void) process: (NSMutableString *) translationSrc {
    int endOfInput = translationSrc.length-1;
    
    //trim last six words
    int whitespaceCounter = 0;
    const int WHITESPACES_FOR_SIX_WORDS = 7;
    for (NSUInteger i = translationSrc.length-1; i >= 0; i--) {
        NSString *m = [translationSrc substringWithRange:NSMakeRange(i, 1)];
        if ([m isEqualToString:@" "]) {
            whitespaceCounter++;
        }
        if (whitespaceCounter == WHITESPACES_FOR_SIX_WORDS) {
            if (i > 0) {
                endOfInput = i-1;
            }
            break;
        }
    }

    NSMutableString *word = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *dictionary = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *transcriptionURL = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *translation = [[NSMutableString alloc] initWithString:@""];
    for (NSUInteger i = 0; i < endOfInput; i++) {

    }
}
@end