//
//  Created by lynx on 12/9/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EnRuIndent_Tests.h"
#import "Eng2RuPostProcessor.h"


@implementation EnRuIndent_Tests

-(void)setUp {
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

- (void)test_process_enru_hello_indent {
    NSString *src = @"1. межд. ; = hallo, hullo 1) алло! 2) привет! 2. сущ. ; мн.  hellos; = hallo, hullo приветствие ; приветственный возглас , оклик ; восклицание , удивление 3. гл. ; = hallo, hullo а) здороваться б) приветствовать ; звать , окликать";
    NSString *expected = @"1. межд.; = hallo, hullo\n"
            "\t1) алло!\n"
            "\t2) привет!\n"
            "2. сущ.; мн. hellos; = hallo, hullo приветствие; приветственный возглас, оклик; восклицание, удивление\n"
            "3. гл.; = hallo, hullo\n"
            "\tа) здороваться\n"
            "\tб) приветствовать; звать, окликать";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    NSMutableString *result = [processor fixIndentation:src];
    STAssertTrue([result isEqualToString:expected], @"Not expected result: %@", result);
}

@end