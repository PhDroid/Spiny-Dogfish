//
//  Created by lynx on 11/30/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol Eng2RuHTMLParserDelegate;


@interface Eng2RuHTMLParser : NSObject {
    id < Eng2RuHTMLParserDelegate > delegate;
}
@property(retain) id delegate;
-(void) parse: (NSData *) bareHTML;
@end