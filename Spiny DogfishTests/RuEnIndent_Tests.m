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

- (void)test_process_ruen_application_indent {
    NSString *src = @"с. 1) ( прикладывание ) apposition , affixing 2) ( приложенные документы и т.п. ) enclosure , attachment 3) ( к журналу и т.п. ) appendix ( pl -ices , -ixes ) ; supplement ; ( к договору ) appendix , schedule 4) грам. apposition 5) ( применение ) application 6) информ. ( прикладная программа ) application ; ( прикладной модуль программы ) plug-in";
    NSString *expected = @"1. сущ.\n"
            "\t1) проверка, испытание; тест\n"
            "\t2)\n"
            "\t\tа) проверочная, контрольная работа; тест\n"
            "\t\tб) психол. тест\n"
            "\t3) мерило; критерий\n"
            "\t4) мед.; хим. исследование, анализ; проверка\n"
            "\t5) хим. реактив\n"
            "\t6) пробирная чашка для определения пробы (драгоценного металла)\n"
            "2. гл.\n"
            "\t1)\n"
            "\t\tа) подвергать испытанию, проверке\n"
            "\t\tб) подвергаться испытанию, проходить тест\n"
            "\t\tв) амер. показать в результате испытания, дать результат; обнаруживать определённые свойства в результате испытаний\n"
            "\t2)\n"
            "\t\tа) = test out тестировать; проверять с помощью тестов\n"
            "\t\tб) экзаменовать\n"
            "\t3) проверять, убеждаться\n"
            "\t4)\n"
            "\t\tа) хим. подвергать действию реактива; брать пробу\n"
            "\t\tб) производить опыты\n"
            "\t\tв) определять пробу (драгоценного металла)\n"
            "3. прил. испытательный, пробный, контрольный, проверочный";
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