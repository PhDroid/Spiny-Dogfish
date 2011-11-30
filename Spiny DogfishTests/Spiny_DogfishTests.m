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

- (void)testExample
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"word-random"
                                                     ofType:@"txt"];

    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    Eng2RuHTMLParser *parser = [[Eng2RuHTMLParser alloc] init];
    @try {
        NSMutableString *result = [parser parseHTMLString:content];
        NSLog(result);
        NSString *expected = @"";
        STAssertEquals(result, expected, @"Not expected result");
    } @catch (Eng2RuNotFoundException *e) {
        STFail(@"Parsing this word should not give errors.");
    }
}

@end
