//
//  Created by lynx on 12/8/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EnRuTranslate_Tests.h"
#import "Eng2RuHTMLParser.h"
#import "Eng2RuNotFoundException.h"


@implementation EnRuTranslate_Tests

-(void)setUp {
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

- (void)test_translate_enru_hello {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"enru-hello"
                                                     ofType:@"html"];
    NSError *error;
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSString *expected = @"hello LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text='he'l%C9%99u\"] брит.                      / амер.                      1. межд. ; = hallo, hullo 1) алло! 2) привет! 2. сущ. ; мн.  hellos; = hallo, hullo приветствие ; приветственный возглас , оклик ; восклицание , удивление 3. гл. ; = hallo, hullo а) здороваться б) приветствовать ; звать , окликать Розгорнути статтю &#187; &#171; Згорнути статтю ";
        STAssertTrue( [result isEqualToString: expected], @"Not expected result: %@", result);
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

@end