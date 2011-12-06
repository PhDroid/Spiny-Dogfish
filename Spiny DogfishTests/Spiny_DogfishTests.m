//
//  Spiny_DogfishTests.m
//  Spiny DogfishTests
//
//  Created by Max Korenkov on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Spiny_DogfishTests.h"
#import "Eng2RuHTMLParser.h"
#import "Eng2RuNotFoundException.h"
#import "Eng2RuPostProcessor.h"

@implementation Spiny_DogfishTests
- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)test_translate_enru_random {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"word-random"
                                                     ofType:@"txt"];
    NSError *error;
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSString *expected = @"random LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text='r%C3%A6nd%C9%99m\"] брит.                      / амер.                      прил. сделанный или выбранный наугад ; случайный , произвольный Розгорнути статтю &#187; &#171; Згорнути статтю ";
        STAssertTrue( [result isEqualToString: expected], @"Not expected result: %@", result);
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

- (void)test_translate_enru_random2 {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"html-random-2011-11"
                                                     ofType:@"txt"];
    NSError *error;
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSString *expected = @"random LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text='r%C3%A6nd%C9%99m\"] брит.                      / амер.                      прил. сделанный или выбранный наугад ; случайный , произвольный Розгорнути статтю &#187; &#171; Згорнути статтю ";
        STAssertTrue( [result isEqualToString: expected], @"Not expected result: %@", result);
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

- (void)test_translate_enru_children {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"html-children"
                                                     ofType:@"txt"];
    NSError *error;
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSString *expected = @"children LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text='%CA%A7%C9%AAldr(%C9%99)n\"] брит.                      / амер.                      мн.  от child ";
        STAssertTrue( [result isEqualToString: expected], @"Not expected result: %@", result);
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

- (void)test_translate_enru_test {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"word-test"
                                                     ofType:@"txt"];
    NSError *error;
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSString *expected = @"test LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text=test\"] брит.                      / амер.                      1. сущ. 1) проверка , испытание ; тест 2) а) проверочная , контрольная работа ; тест б) психол.  тест 3) мерило ; критерий 4) мед. ; хим.  исследование , анализ ; проверка 5) хим.  реактив 6) пробирная чашка для определения пробы  ( драгоценного металла ) 2. гл. 1) а) подвергать испытанию , проверке б) подвергаться испытанию , проходить тест в) амер.  показать в результате испытания , дать результат ; обнаруживать определённые свойства в результате испытаний 2) а) = test out тестировать ; проверять с помощью тестов б) экзаменовать 3) проверять , убеждаться 4) а) хим.  подвергать действию реактива ; брать пробу б) производить опыты в) определять пробу  ( драгоценного металла ) 3. прил. испытательный , пробный , контрольный , проверочный Розгорнути статтю &#187; &#171; Згорнути статтю ";
        STAssertTrue( [result isEqualToString: expected], @"Not expected result: %@", result);
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

- (void)test_translate_ruen_zany {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ruen-zany"
                                                     ofType:@"html"];
    NSError *error;
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSString *expected = @"test LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text=test\"] брит.                      / амер.                      1. сущ. 1) проверка , испытание ; тест 2) а) проверочная , контрольная работа ; тест б) психол.  тест 3) мерило ; критерий 4) мед. ; хим.  исследование , анализ ; проверка 5) хим.  реактив 6) пробирная чашка для определения пробы  ( драгоценного металла ) 2. гл. 1) а) подвергать испытанию , проверке б) подвергаться испытанию , проходить тест в) амер.  показать в результате испытания , дать результат ; обнаруживать определённые свойства в результате испытаний 2) а) = test out тестировать ; проверять с помощью тестов б) экзаменовать 3) проверять , убеждаться 4) а) хим.  подвергать действию реактива ; брать пробу б) производить опыты в) определять пробу  ( драгоценного металла ) 3. прил. испытательный , пробный , контрольный , проверочный Розгорнути статтю &#187; &#171; Згорнути статтю ";
        STAssertTrue( [result isEqualToString: expected], @"Not expected result: %@", result);
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

- (void)test_translate_ruen_application {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"ruen-application"
                                                     ofType:@"html"];
    NSError *error;
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSString *expected = @"test LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text=test\"] брит.                      / амер.                      1. сущ. 1) проверка , испытание ; тест 2) а) проверочная , контрольная работа ; тест б) психол.  тест 3) мерило ; критерий 4) мед. ; хим.  исследование , анализ ; проверка 5) хим.  реактив 6) пробирная чашка для определения пробы  ( драгоценного металла ) 2. гл. 1) а) подвергать испытанию , проверке б) подвергаться испытанию , проходить тест в) амер.  показать в результате испытания , дать результат ; обнаруживать определённые свойства в результате испытаний 2) а) = test out тестировать ; проверять с помощью тестов б) экзаменовать 3) проверять , убеждаться 4) а) хим.  подвергать действию реактива ; брать пробу б) производить опыты в) определять пробу  ( драгоценного металла ) 3. прил. испытательный , пробный , контрольный , проверочный Розгорнути статтю &#187; &#171; Згорнути статтю ";
        STAssertTrue( [result isEqualToString: expected], @"Not expected result: %@", result);
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

- (void)test_process_enru_test {
    NSString *src = @"test LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text=test\"] брит.                      / амер.                      1. сущ. 1) проверка , испытание ; тест 2) а) проверочная , контрольная работа ; тест б) психол.  тест 3) мерило ; критерий 4) мед. ; хим.  исследование , анализ ; проверка 5) хим.  реактив 6) пробирная чашка для определения пробы  ( драгоценного металла ) 2. гл. 1) а) подвергать испытанию , проверке б) подвергаться испытанию , проходить тест в) амер.  показать в результате испытания , дать результат ; обнаруживать определённые свойства в результате испытаний 2) а) = test out тестировать ; проверять с помощью тестов б) экзаменовать 3) проверять , убеждаться 4) а) хим.  подвергать действию реактива ; брать пробу б) производить опыты в) определять пробу  ( драгоценного металла ) 3. прил. испытательный , пробный , контрольный , проверочный Розгорнути статтю &#187; &#171; Згорнути статтю ";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    [processor process:[[NSMutableString alloc] initWithString:src]];
    STAssertTrue([[processor getWord] isEqualToString:@"test"], @"Not expected result: %@", [processor getWord]);
    STAssertTrue([[processor getDictionary] isEqualToString:@"LingvoUniversal (En-Ru)"], @"Not expected result: %@", [processor getDictionary]);
    STAssertTrue([[processor getTranscriptionUrl] isEqualToString:@"/Handlers/TranscriptionHandler.ashx?Text=test"], @"Not expected result: %@", [processor getTranscriptionUrl]);
    STAssertTrue([[processor getTranslation] isEqualToString:@"1. сущ. 1) проверка , испытание ; тест 2) а) проверочная , контрольная работа ; тест б) психол.  тест 3) мерило ; критерий 4) мед. ; хим.  исследование , анализ ; проверка 5) хим.  реактив 6) пробирная чашка для определения пробы  ( драгоценного металла ) 2. гл. 1) а) подвергать испытанию , проверке б) подвергаться испытанию , проходить тест в) амер.  показать в результате испытания , дать результат ; обнаруживать определённые свойства в результате испытаний 2) а) = test out тестировать ; проверять с помощью тестов б) экзаменовать 3) проверять , убеждаться 4) а) хим.  подвергать действию реактива ; брать пробу б) производить опыты в) определять пробу  ( драгоценного металла ) 3. прил. испытательный , пробный , контрольный , проверочный"], @"Not expected result: %@", [processor getTranslation]);
}

- (void)test_process_enru_random {
    NSString *src = @"random LingvoUniversal (En-Ru) [ =\"/Handlers/TranscriptionHandler.ashx?Text='r%C3%A6nd%C9%99m\"] брит.                      / амер.                      прил. сделанный или выбранный наугад ; случайный , произвольный Розгорнути статтю &#187; &#171; Згорнути статтю ";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    [processor process:[[NSMutableString alloc] initWithString:src]];
    STAssertTrue([[processor getWord] isEqualToString:@"random"], @"Not expected result: %@", [processor getWord]);
    STAssertTrue([[processor getDictionary] isEqualToString:@"LingvoUniversal (En-Ru)"], @"Not expected result: %@", [processor getDictionary]);
    STAssertTrue([[processor getTranscriptionUrl] isEqualToString:@"/Handlers/TranscriptionHandler.ashx?Text='r%C3%A6nd%C9%99m"], @"Not expected result: %@", [processor getTranscriptionUrl]);
    STAssertTrue([[processor getTranslation] isEqualToString:@"прил. сделанный или выбранный наугад ; случайный , произвольный"], @"Not expected result: %@", [processor getTranslation]);
}

- (void)test_process_enru_test_indent {
    NSString *src = @"1. сущ. 1) проверка , испытание ; тест 2) а) проверочная , контрольная работа ; тест б) психол.  тест 3) мерило ; критерий 4) мед. ; хим.  исследование , анализ ; проверка 5) хим.  реактив 6) пробирная чашка для определения пробы  ( драгоценного металла ) 2. гл. 1) а) подвергать испытанию , проверке б) подвергаться испытанию , проходить тест в) амер.  показать в результате испытания , дать результат ; обнаруживать определённые свойства в результате испытаний 2) а) = test out тестировать ; проверять с помощью тестов б) экзаменовать 3) проверять , убеждаться 4) а) хим.  подвергать действию реактива ; брать пробу б) производить опыты в) определять пробу  ( драгоценного металла ) 3. прил. испытательный , пробный , контрольный , проверочный";
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

- (void)test_process_enru_random_indent {
    NSString *src = @"прил. сделанный или выбранный наугад ; случайный , произвольный";
    NSString *expected = @"прил.\n"
            "сделанный или выбранный наугад; случайный, произвольный";
    Eng2RuPostProcessor *processor = [[Eng2RuPostProcessor alloc]init];
    NSMutableString *result = [processor fixIndentation:src];
    STAssertTrue([result isEqualToString:expected], @"Not expected result: %@", result);
}

@end
