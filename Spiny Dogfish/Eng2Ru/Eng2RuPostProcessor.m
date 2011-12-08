//
//  Created by lynx on 12/1/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "Eng2RuPostProcessor.h"
#import "Eng2RuNotFoundException.h"


@implementation Eng2RuPostProcessor
NSMutableString *word;
NSMutableString *dictionary;
NSMutableString *transcriptionURL;
NSMutableString *translation;

-(NSString *) getWord{
    return word;
}
-(NSString *) getDictionary{
    return dictionary;
}
-(NSString *) getTranscriptionUrl{
    return transcriptionURL;
}
-(NSString *) getTranslation {
    return translation;
}

-(void) processRuEn: (NSMutableString *) translationSrc {
    int endOfInput = translationSrc.length-1;
    NSString *stressChar = @"´";

    //append words in the beginning to have the word
    word = [[NSMutableString alloc] initWithString:@""];
    dictionary = [[NSMutableString alloc] initWithString:@""];


    NSString *ruEnPattern = @"Ru-En";
    NSRange ruEnMatch;
    ruEnMatch = [translationSrc rangeOfString: ruEnPattern];

    int whitespaceCounter = 0;
    int endOfWord = 0;
    for (int i = ruEnMatch.location; i >= 0; i--) {
        NSString *m = [translationSrc substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        if ([m isEqualToString:@" "]) {
            whitespaceCounter++;
        }

        if (whitespaceCounter == 1 &&
                ![m isEqualToString:@" "]) {
            [dictionary insertString:@"m" atIndex:0];
        }
        if (whitespaceCounter == 2 &&
                ![m isEqualToString:@" "]) {
            endOfWord = i;
            break;
        }
    }

    [dictionary appendFormat: @" (Ru-En)"];

    whitespaceCounter = 0;
    for (int i = 0; i < endOfWord; i++){
        NSString *m = [translationSrc substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        if ([m isEqualToString: @" "]) {
            whitespaceCounter++;
        }
        
        if (whitespaceCounter == 1 &&
                [m isEqualToString: @" "]) {
            [word appendString:stressChar];
        } else if (![m isEqualToString:@" "]) {
            [word appendString:m];
        }
    }

    //trim last six words
    whitespaceCounter = 0;
    const int WHITESPACES_FOR_SIX_WORDS = 7;
    for (int i = translationSrc.length-1; i >= 0; i--) {
        NSString *m = [translationSrc substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        if ([m isEqualToString:@" "]) {
            whitespaceCounter++;
        }
        if (whitespaceCounter == WHITESPACES_FOR_SIX_WORDS) {
            if (i > 0) {
                endOfInput = i;
            }
            break;
        }
    }

    transcriptionURL = [[NSMutableString alloc] initWithString:@""];
    translation = [[NSMutableString alloc] initWithString:@""];
    whitespaceCounter = 0;
    for (int i = ruEnMatch.location; i < endOfInput; i++) {
        NSString *m = [translationSrc substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        bool isWhitespace = [m isEqualToString:@" "];
        if (isWhitespace) {
            whitespaceCounter++;
        }
        if (whitespaceCounter < 1) {
            //do nothing;
        } else if (!isWhitespace) {
            [translation appendString:m];
        }
    }
}

-(void) processEnRu: (NSMutableString *) translationSrc {
    int endOfInput = translationSrc.length-1;
    
    //trim last six words
    int whitespaceCounter = 0;
    const int WHITESPACES_FOR_SIX_WORDS = 7;
    for (int i = translationSrc.length-1; i >= 0; i--) {
        NSString *m = [translationSrc substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        if ([m isEqualToString:@" "]) {
            whitespaceCounter++;
        }
        if (whitespaceCounter == WHITESPACES_FOR_SIX_WORDS) {
            if (i > 0) {
                endOfInput = i;
            }
            break;
        }
    }

    word = [[NSMutableString alloc] initWithString:@""];
    dictionary = [[NSMutableString alloc] initWithString:@""];
    transcriptionURL = [[NSMutableString alloc] initWithString:@""];
    translation = [[NSMutableString alloc] initWithString:@""];
    whitespaceCounter = 0;
    bool transcriptionModeWriting = false;
    NSString * transcriptionModeTrigger = @"";
    int phase = 0;
    int phase3WordCount = 0;
    const int PHASE3_EXPECTED_WORD_COUNT = 3;
    NSString *phase3PrevChar = @"";
    bool phase4Writing = false;
    for (int i = 0; i < endOfInput; i++) {
        NSString *m = [translationSrc substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        bool isWhitespace = [m isEqualToString:@" "];
        if (isWhitespace) {
            whitespaceCounter++;
        }
        if (phase == 0 && whitespaceCounter == 0) {
            [word appendString:m];
        }
        if (whitespaceCounter == 1 || whitespaceCounter == 2) {
            if (phase == 0){
                phase = 1;
                continue;
            }
            if (phase == 1) {
                [dictionary appendString:m];
            }
        }
        //phase 2 - transcription url
        if ([m isEqualToString:@"["]) {
            if (phase == 1) {
                phase = 2;
                continue;
            }
        }
        if ([m isEqualToString:@"]"]) {
            if (phase == 2) {
                phase = 3;
                continue;
            }
        }
        if (phase == 2) {
            if (!transcriptionModeWriting &&
                    ([m isEqualToString: @"'"] || [m isEqualToString: @"\""])) {
                transcriptionModeWriting = true;
                transcriptionModeTrigger = m;
                continue;
            }
            if (transcriptionModeWriting &&
                    [m isEqualToString: transcriptionModeTrigger]) {
                transcriptionModeWriting = false;
                continue;
            }
            if (transcriptionModeWriting)
            {
                [transcriptionURL appendString: m];
                continue;
            }
        }
        // skip 2 words in phase#3
        if (phase == 3) {
            if(isWhitespace &&
                    ![phase3PrevChar isEqualToString:@""] &&
                    ![phase3PrevChar isEqualToString: @" "]){
                phase3WordCount++;
            }
            if (phase3WordCount == PHASE3_EXPECTED_WORD_COUNT) {
                phase = 4;
            }
            phase3PrevChar = m;
        }
        // in phase#4 - all the rest except whitespaces
        if (phase == 4) {
            if (isWhitespace) {
                if (!phase4Writing) {
                    continue;
                }
            } else {
                if (!phase4Writing) {
                    phase4Writing = true;
                }
            }
            if (phase4Writing) {
                [translation appendString:m];
            }
        }
    }
}

-(void) process: (NSMutableString *) translationSrc {
    NSString *enRuPattern = @"En-Ru";
    NSString *ruEnPattern = @"Ru-En";

    NSRange enRuMatch;
    NSRange ruEnMatch;

    enRuMatch = [translationSrc rangeOfString: enRuPattern];
    ruEnMatch = [translationSrc rangeOfString: ruEnPattern];

    if (enRuMatch.location != NSNotFound){
        [self processEnRu:translationSrc];
    } else if (ruEnMatch.location != NSNotFound) {
        [self processRuEn:translationSrc];
    } else {
        [Eng2RuNotFoundException raise:@"Translation block was not found or language not in (RU, EN)"];
    }
}

-(bool) isDigit:(NSString *) value {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSNumber *number = [numberFormatter numberFromString:value];
    bool result = number != nil;
    return result;
}
typedef enum {
    None,
    LevelOne,
    LevelTwo,
    LevelThree
} IndentLevel;

-(NSMutableString *) fixComplexIndentation: (NSString *)translation {
    NSMutableString *result = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *word = [[NSMutableString alloc] initWithString:@""];
    IndentLevel level = None;
    for(int i = 0; i < translation.length; i++) {
        NSString *m = [translation substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        if ([m isEqualToString:@" "]) {
            if (word.length > 1) {
                NSString *w_last = [word substringWithRange:NSMakeRange(word.length-1, 1)];
                NSString *w_before_last = [word substringToIndex:word.length-1];
                if ([w_last isEqualToString:@"."] &&
                        [self isDigit:w_before_last] ){
                    if (result.length > 0) {
                        [result appendString:@"\n"];
                    }
                    [result appendString:word];
                    level = LevelOne;
                } else if ([w_last isEqualToString: @")"] &&
                            [self isDigit:w_before_last]) {
                    [result appendFormat:@"\n\t%@", word];
                    switch (level) {
                        case LevelOne:
                            level = LevelTwo;
                            break;
                        case LevelTwo:
                            break;
                        case LevelThree:
                            level = LevelTwo;
                            break;
                        default:
                            [NSException raise:@"Invalid level value" format:@"level of %d is invalid", level];
                    }
                } else if ([w_last isEqualToString: @")"] &&
                            word.length == 2 &&
                            ![self isDigit:w_before_last]) {
                    [result appendFormat:@"\n\t\t%@", word];
                    switch (level) {
                        case LevelTwo:
                            level = LevelThree;
                            break;
                        case LevelThree:
                            break;
                        default:
                            [NSException raise:@"Invalid level value" format:@"level of %d is invalid", level];
                    }
                } else {
                    if (result.length > 0 &&
                            [[result substringWithRange:NSMakeRange(result.length-1, 1)] isEqualToString:@"("]) {
                        [result appendString: word];
                    } else {
                        [result appendFormat:@" %@", word];
                    }


                }
            } else {
                if ([word isEqualToString:@","] || 
                        [word isEqualToString:@")"] || 
                        [word isEqualToString:@";"]) {
                    [result appendString: word];
                } else if ([word isEqualToString:@""] ||
                        [word isEqualToString:@" "]) {
                    //skip
                } else {
                    [result appendFormat:@" %@", word];
                }

            }

            word = [[NSMutableString alloc] initWithString:@""];
        } else {
            [word appendString:m];
            if (i == translation.length-1) {
                [result appendFormat:@" %@", word];
            }
        }
    }
    return result;
}

-(NSMutableString *) fixSimpleIndentation: (NSString *)translation {
    NSMutableString *result = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *word = [[NSMutableString alloc] initWithString:@""];
    int *wordCount = 0;
    for(int i = 0; i < translation.length; i++) {
        NSString *m = [translation substringWithRange:NSMakeRange((NSUInteger)i, 1)];
        if ([m isEqualToString:@" "]) {
            if (word.length > 1) {
                NSString *w_last = [word substringWithRange:NSMakeRange(word.length-1, 1)];
                if ([w_last isEqualToString:@"."] &&
                        wordCount == 0){
                    if (result.length > 0) {
                        [result appendString:@"\n"];
                    }
                    [result appendFormat:@"%@\n", word];
                } else {
                    if (result.length > 0) {
                        NSString *res_last = [result substringWithRange:NSMakeRange(result.length-1, 1)];
                        if ([res_last isEqualToString:@"("] ||
                                [res_last isEqualToString:@"\n"] ||
                                [res_last isEqualToString:@" "]) {
                            [result appendString: word];
                        } else {
                            [result appendFormat:@" %@", word];
                        }
                    }
                    else {
                        [result appendString:word];
                    }
                }
            } else {
                if ([word isEqualToString:@","] ||
                        [word isEqualToString:@")"] ||
                        [word isEqualToString:@";"]) {
                    [result appendString: word];
                } else if ([word isEqualToString:@""] ||
                        [word isEqualToString:@" "]) {
                    //skip
                } else {
                    [result appendFormat:@" %@", word];
                }

            }

            word = [[NSMutableString alloc] initWithString:@""];
            wordCount++;
        } else {
            [word appendString:m];
            if (i == translation.length-1) {
                [result appendFormat:@" %@", word];
            }
        }
    }
    return result;
}

-(NSMutableString *) fixIndentation: (NSString *)translation {
    if (translation.length == 0) {
        return [[NSMutableString alloc] initWithString:translation];
    }
    if ([self isDigit:[translation substringWithRange:NSMakeRange(0, 1)]]){
        return [self fixComplexIndentation:translation];
    } else {
        return [self fixSimpleIndentation:translation];
    }
}

@end