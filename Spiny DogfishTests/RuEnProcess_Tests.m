//
//  Created by lynx on 12/8/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RuEnProcess_Tests.h"
#import "Eng2RuPostProcessor.h"


@implementation RuEnProcess_Tests
-(void)setUp {
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

- (void)test_process_ruen_zany {
    NSString *src = @"прик о льный Universal (Ru-En) жарг. zany ";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    [processor process:[[NSMutableString alloc] initWithString:src]];
    STAssertTrue([[processor getWord] isEqualToString:@"прик´ольный"], @"Not expected result: %@", [processor getWord]);
    STAssertTrue([[processor getDictionary] isEqualToString:@"Universal (Ru-En)"], @"Not expected result: %@", [processor getDictionary]);
    STAssertTrue([[processor getTranscriptionUrl] isEqualToString:@""], @"Not expected result: %@", [processor getTranscriptionUrl]);
    STAssertTrue([[processor getTranslation] isEqualToString:@"жарг. zany"], @"Not expected result: %@", [processor getTranslation]);
}

- (void)test_process_ruen_application {
    NSString *src = @"прилож е ние Universal (Ru-En)                     с. 1) ( прикладывание ) apposition , affixing 2) ( приложенные документы и т.п. ) enclosure , attachment 3) ( к журналу и т.п. ) appendix  ( pl  -ices [ =\"/Handlers/TranscriptionHandler.ashx?Text=-%C9%AAsi%CB%90z\"<spanclass=\"Italic\"], -ixes ) ; supplement ; ( к договору ) appendix , schedule 4) грам.  apposition 5) ( применение ) application 6) информ.  ( прикладная программа ) application ; ( прикладной модуль программы ) plug-in Розгорнути статтю &#187; &#171; Згорнути статтю ";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    [processor process:[[NSMutableString alloc] initWithString:src]];
    STAssertTrue([[processor getWord] isEqualToString:@"прилож´ение"], @"Not expected result: %@", [processor getWord]);
    STAssertTrue([[processor getDictionary] isEqualToString:@"Universal (Ru-En)"], @"Not expected result: %@", [processor getDictionary]);
    STAssertTrue([[processor getTranscriptionUrl] isEqualToString:@""], @"Not expected result: %@", [processor getTranscriptionUrl]);
    STAssertTrue([[processor getTranslation] isEqualToString:@"с. 1) ( прикладывание ) apposition , affixing 2) ( приложенные документы и т.п. ) enclosure , attachment 3) ( к журналу и т.п. ) appendix  ( pl  -ices , -ixes ) ; supplement ; ( к договору ) appendix , schedule 4) грам.  apposition 5) ( применение ) application 6) информ.  ( прикладная программа ) application ; ( прикладной модуль программы ) plug-in Розгорнути статтю &#187; &#171; Згорнути статтю "], @"Not expected result: %@", [processor getTranslation]);
}

@end