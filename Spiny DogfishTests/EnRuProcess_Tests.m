//
//  Created by lynx on 12/8/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "EnRuProcess_Tests.h"
#import "Eng2RuPostProcessor.h"


@implementation EnRuProcess_Tests

-(void)setUp {
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

- (void)test_process_enru_hello {
    NSString *src = @"hello LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text='he'l%C9%99u\"] брит.                      / амер.                      1. межд. ; = hallo, hullo 1) алло! 2) привет! 2. сущ. ; мн.  hellos; = hallo, hullo приветствие ; приветственный возглас , оклик ; восклицание , удивление 3. гл. ; = hallo, hullo а) здороваться б) приветствовать ; звать , окликать Розгорнути статтю &#187; &#171; Згорнути статтю ";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    [processor process:[[NSMutableString alloc] initWithString:src]];
    STAssertTrue([[processor getWord] isEqualToString:@"hello"], @"Not expected result: %@", [processor getWord]);
    STAssertTrue([[processor getDictionary] isEqualToString:@"LingvoUniversal (En-Ru)"], @"Not expected result: %@", [processor getDictionary]);
    STAssertTrue([[processor getTranscriptionUrl] isEqualToString:@"/Handlers/TranscriptionHandler.ashx?Text='he'l%C9%99u"], @"Not expected result: %@", [processor getTranscriptionUrl]);
    STAssertTrue([[processor getTranslation] isEqualToString:@"1. межд. ; = hallo, hullo 1) алло! 2) привет! 2. сущ. ; мн.  hellos; = hallo, hullo приветствие ; приветственный возглас , оклик ; восклицание , удивление 3. гл. ; = hallo, hullo а) здороваться б) приветствовать ; звать , окликать"], @"Not expected result: %@", [processor getTranslation]);
}

@end