//
//  Created by lynx on 11/30/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Eng2RuHTMLParser.h"
#import "Eng2RuNotFoundException.h"


@implementation Eng2RuHTMLParser

- (NSMutableString *)parse:(NSData *) bareHTML {
    NSString *receivedString = [[NSString alloc] initWithData:bareHTML
            encoding:NSUTF8StringEncoding];
    NSLog( @"From connectionDidFinishLoading: %@", receivedString );

    NSString *start_pattern = @"<div class=\"data card\">";

    NSRange match;

    match = [receivedString rangeOfString: start_pattern];

    if (match.location == NSNotFound){
        [Eng2RuNotFoundException raise:@"Data block was not found"];
    }
    
    NSUInteger position = match.location;
    int depthCount = 0;
    bool propertyValueMode = false;
    bool ignoreNextSymbol = false;
    bool opening = false;
    bool closing = false;
    bool writing = false;
    NSMutableString *resultText = [[NSMutableString alloc] initWithString:@""];

    for (NSUInteger i = position; true; i++) {
        if (ignoreNextSymbol) {
            ignoreNextSymbol = false;
            continue;
        }
        NSString *m = [receivedString substringWithRange:NSMakeRange(i, 1)];

        //ignore characters
        if ([m isEqualToString: @"\r"] ||
                [m isEqualToString: @"\n"] ||
                [m isEqualToString: @"\t"]) {
            continue;
        }

        if ([m isEqualToString: @"'"] || [m isEqualToString: @"\""]) { //property value mode
            propertyValueMode = !propertyValueMode;
            continue;
        }
        if ([m isEqualToString: @"\\"]) { //escape symbol
            ignoreNextSymbol = true;
            continue;
        }
        if (propertyValueMode) { //ignore everything while in property value mode
            continue;
        }
        if ([m isEqualToString: @"/"]) {
            closing = true;
            opening = false;
            continue;
        }
        if ([m isEqualToString: @">"]) {
            if (closing) {
                closing = false;
                depthCount--;
            }
            if (opening) {
                opening = false;
                depthCount++;
            }
            if (writing) {
                [resultText appendString:@" "];
                writing = false;
            }
            continue;
        }
        if ([m isEqualToString: @"<"]) {
            opening = true;
            continue;
        }

        if (!opening && !closing) { // main logic
            //ignore more than one space
            if (resultText.length > 0 &&
                    ![[resultText substringWithRange:NSMakeRange(resultText.length, 1)] isEqualToString: @" "]) {
                [resultText appendString:m];
            }
            writing = true;
        } else {
            writing = false;
        }

        if (!opening && depthCount == 0) {
            break;
        }
    }

    return resultText;
}

@end