//
//  Created by lynx on 11/30/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface Eng2RuHTMLParser : NSObject
-(NSMutableString *) parseHTMLData: (NSData *) bareHTML;
-(NSMutableString *) parseHTMLString: (NSString *) bareHTML;
@end