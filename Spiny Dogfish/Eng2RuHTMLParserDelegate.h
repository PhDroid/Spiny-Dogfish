//
//  Created by lynx on 11/30/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


@protocol Eng2RuHTMLParserDelegate
-(void)dataCardNotFound;
-(void)dataCardParsed:(NSMutableString *)result;
@end