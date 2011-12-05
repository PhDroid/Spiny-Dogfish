//
//  Created by lynx on 11/30/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Eng2RuHTMLParser.h"
#import "Eng2RuNotFoundException.h"
#import "SimpleStack.h"
#import "Eng2RuParsingException.h"


@implementation Eng2RuHTMLParser

- (NSMutableString *)parseHTMLData:(NSData *) bareHTML {
    NSString *receivedString = [[NSString alloc] initWithData:bareHTML
            encoding:NSUTF8StringEncoding];
    return [self parseHTMLString:receivedString];
}

- (NSMutableString *)parseHTMLString:(NSString *) receivedString {
    NSString *start_pattern = @"<div class=\"data card\">";

    NSRange match;

    match = [receivedString rangeOfString: start_pattern];

    if (match.location == NSNotFound){
        [Eng2RuNotFoundException raise:@"Data block was not found"];
    }
    
    NSUInteger position = match.location;
    //todo:change depthCount into stack
    SimpleStack *stack = [[SimpleStack alloc] init];
    int depthCount = 0;
    bool propertyValueMode = false;
    NSString *propertyModeInitiator = @"";
    bool ignoreNextSymbol = false;
    bool opening = false;
    bool closing = false;
    bool transcriptionMode = false;
    bool transcriptionURLMode = false;
    NSMutableString * lastProperty_TranscriptionMode = [[NSMutableString alloc] initWithString:@""];
    NSMutableString * transcriptionUrl = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *resultText = [[NSMutableString alloc] initWithString:@""];
    bool writingTagName = false;
    NSMutableString *tagName = [[NSMutableString alloc] initWithString:@""];

    for (NSUInteger i = position; i < receivedString.length; i++) {
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
        
        if ([m isEqualToString:@"["]) {
            transcriptionMode = true;
        }
        if ([m isEqualToString:@"]"]) {
            transcriptionMode = false;
            if (transcriptionURLMode) {
                [resultText appendString:transcriptionUrl];
                transcriptionURLMode = false;
            }
            lastProperty_TranscriptionMode = [[NSMutableString alloc] initWithString:@""];
        }
        if (transcriptionMode) {
            if ([m isEqualToString: @"="]) {
                if ([lastProperty_TranscriptionMode isEqualToString:@"src"]) {
                    transcriptionURLMode = true;
                }
                lastProperty_TranscriptionMode = [[NSMutableString alloc] initWithString:@""];
            }
            if ([m isEqualToString: @" "]){
                lastProperty_TranscriptionMode = [[NSMutableString alloc] initWithString:@""];
            } else if ([m isEqualToString: @">"]) {
                //do nothing
            } else if (!transcriptionURLMode) {
                [lastProperty_TranscriptionMode appendString:m];
            } else {
                [transcriptionUrl appendString:m];
            }
        }
        

        if ([m isEqualToString: @"'"] || [m isEqualToString: @"\""]) { //property value mode
            if (!propertyValueMode) {
                propertyModeInitiator = m;
                propertyValueMode = true;
            } else if ([propertyModeInitiator isEqualToString: m]) {
                propertyModeInitiator = @"";
                propertyValueMode = false;
            }
            continue;
        }
        if ([m isEqualToString: @"\\"]) { //escape symbol
            ignoreNextSymbol = true;
            continue;
        }
        if (propertyValueMode) { //ignore everything while in property value mode
            continue;
        }
        if (opening && [m isEqualToString: @"/"]) {
            closing = true;
            opening = false;
            continue;
        }
        if ([m isEqualToString: @">"]) {
            if (closing) {
                closing = false;
                NSString *openingTag = (NSString *)[stack pop];
                if (![tagName isEqualToString:openingTag]) {
                    //todo: change to own exception
                    //[NSException raise:@"Opening and closing tag do not match %@ == %@", openingTag, tagName];
                }
                tagName = [[NSMutableString alloc] init];
                writingTagName = false;
            }
            if (opening) {
                opening = false;
            }
            if (resultText.length > 0 &&
                ![[resultText substringWithRange:NSMakeRange(resultText.length-1, 1)] isEqualToString: @" "]) {
                [resultText appendString:@" "];
            }
        }
        if ([m isEqualToString: @"<"]) {
            opening = true;
            writingTagName = true;
        }

        if (writingTagName) {
            if ([m isEqualToString:@" "] ||
                    [m isEqualToString:@">"]) {

                if ([tagName isEqualToString:@"img"] ||
                        [tagName isEqualToString:@"param"]){
                    //skip
                    tagName = [[NSMutableString alloc] init];
                } else {
                    [stack push:[[NSString alloc] initWithString:tagName]];
                    tagName = [[NSMutableString alloc] init];
                }
                writingTagName = false;
            } else if ([m isEqualToString:@"/"] ||
                    [m isEqualToString:@"<"]) {
                //skip
            } else {
                [tagName appendString:m];
            }
        }

        if (!opening && !closing) { // main logic
            if ([m isEqualToString: @"<"] ||
                    [m isEqualToString: @">"]){
                //ignore
            } else if (resultText.length == 0) {
                [resultText appendString:m];
            } else {
                 if ([m isEqualToString:@" "] &&
                        ![[resultText substringWithRange:NSMakeRange(resultText.length-1, 1)] isEqualToString: @" "]) {
                    //ignore more than one space
                    [resultText appendString:m];
                } else {
                    [resultText appendString:m];
                }
            }
        }

        if (!opening && stack.length == 0) {
            break;
        }
    }

    return resultText;
}

@end