//
//  Created by lynx on 12/1/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Eng2RuPostProcessor : NSObject
-(void) process: (NSMutableString *) translation;
-(NSString *) getWord;
-(NSString *) getDictionary;
-(NSString *) getTranscriptionUrl;
-(NSString *) getTranslation;
@end