//
//  Created by lynx on 12/8/11.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RuEnIndent_Tests.h"
#import "Eng2RuPostProcessor.h"


@implementation RuEnIndent_Tests

-(void)setUp {
    [super setUp];
    // Set-up code here.
}

- (void)tearDown {
    // Tear-down code here.
    [super tearDown];
}

- (void)test_process_enru_wayfarer_indent {
    //todo: move to proper testcase
    NSString *src = @"сущ. ; книжн. путник , странник";
    NSString *expected = @"сущ.; книжн.\n"
            "путник, странник";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    NSMutableString *result = [processor fixIndentation:src];
    STAssertTrue([result isEqualToString:expected], @"Not expected result: %@", result);
}

- (void)test_process_ruen_foreign_indent {
    //заморское
    NSString *src = @"народно-поэт. , уст. и ирон. overseas , foreign";
    NSString *expected = @"народно-поэт., уст. и ирон.\n"
            "overseas, foreign";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    NSMutableString *result = [processor fixIndentation:src];
    STAssertTrue([result isEqualToString:expected], @"Not expected result: %@", result);
}

- (void)test_process_ruen_application_indent {
    NSString *src = @"с. 1) ( прикладывание ) apposition , affixing 2) ( приложенные документы и т.п. ) enclosure , attachment 3) ( к журналу и т.п. ) appendix ( pl -ices , -ixes ) ; supplement ; ( к договору ) appendix , schedule 4) грам. apposition 5) ( применение ) application 6) информ. ( прикладная программа ) application ; ( прикладной модуль программы ) plug-in";
    NSString *expected = @"с.\n"
            "1) (прикладывание) apposition, affixing\n"
            "2) (приложенные документы и т.п.) enclosure, attachment\n"
            "3) (к журналу и т.п.) appendix (pl -ices, -ixes); supplement; (к договору) appendix, schedule\n"
            "4) грам. apposition\n"
            "5) (применение) application\n"
            "6) информ. (прикладная программа) application; (прикладной модуль программы) plug-in";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    NSMutableString *result = [processor fixIndentation:src];
    STAssertTrue([result isEqualToString:expected], @"Not expected result: %@", result);
}

- (void)test_process_ruen_zany_indent {
    NSString *src = @"жарг. zany";
    NSString *expected = @"жарг.\n"
            "zany";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    NSMutableString *result = [processor fixIndentation:src];
    STAssertTrue([result isEqualToString:expected], @"Not expected result: %@", result);
}

@end