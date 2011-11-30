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
    whitespaceCounter = 0;
    bool transcriptionMode = false;
    bool transcriptionModeWriting = false;
    for (NSUInteger i = 0; i < endOfInput; i++) {
        NSString *m = [translationSrc substringWithRange:NSMakeRange(i, 1)];
        if ([m isEqualToString:@" "]) {
            whitespaceCounter++;
        }
        if (whitespaceCounter == 0) {
            [word appendString:m];
        } else if (whitespaceCounter > 0 && whitespaceCounter < 2) {
            [dictionary appendString:m];
        }
        if ([m isEqualToString:@"["]) {
            transcriptionMode = true;
        }
        if ([m isEqualToString:@"]"]) {
            transcriptionMode = false;
        }
        if (transcriptionModeWriting) {
            [transcriptionURL appendString: m];
            continue;
        }
        if (transcriptionMode) {
            if ([m isEqualToString: @"'"] || [m isEqualToString: @"\""]) {
                transcriptionModeWriting = true;
                continue;
            }
            if (transcriptionModeWriting && [m isEqualToString: @"'"] || [m isEqualToString: @"\""]) {
                transcriptionModeWriting = false;
                continue;
            }
        }

    }
}
@end