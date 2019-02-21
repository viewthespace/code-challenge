//
//  WeekOneCodingChallengeTests.m
//  WeekOneCodingChallengeTests
//
//  Created by Nathaniel Linsky on 9/17/15.
//  Copyright (c) 2015 VTS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface WeekOneCodingChallengeTests : XCTestCase

@property NSArray *invalidInputs;

@property NSArray *validInputs;

-(BOOL) solution:(NSArray*) input;

@end

@implementation WeekOneCodingChallengeTests


- (void)setUp {
    [super setUp];
    
    self.invalidInputs = @[
                           
                           @[
                               @[@0, @0, @0,    @0, @0, @0,        @1    ,     @7     ,    @9    ],
                               @[@0, @0, @0,    @0, @0, @0,        @2    ,     @8     ,    @5    ],
                               @[@0, @0, @0,    @0, @0, @0,        @3    ,     @4     ,    @6    ],
                               
                               @[@0, @0, @0,        @1    ,     @2    ,     @3    ,    @0, @0 ,@0],
                               @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0],
                               @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0],
                               
                               @[    @1    ,     @2    ,     @4    ,        @5    ,     @6    ,     @7    ,        @8    ,     @3     ,    @9    ],
                               @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0],
                               @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0]
                               ],
                           
                           @[
                               @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                               @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                               @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                               @[    @1    , @0, @0, @0, @0, @0, @0, @0 ,@0],
                               @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                               @[@0, @0,     @1    , @0, @0, @0, @0, @0 ,@0],
                               @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                               @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                               @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0]
                               ],
                           
                           @[
                               @[    @1    ,     @9    , @0,    @0, @0, @0,    @0, @0 ,@8],
                               @[    @2    ,     @8    , @0,    @0, @8, @0,    @0, @0 ,@0],
                               @[    @3    ,     @7    , @0,    @0, @0, @0,    @0, @0 ,@0],
                               @[    @4    ,     @0,     @0,    @0, @0, @0,    @0, @0 ,@0],
                               @[    @5    ,     @0,     @0,    @0, @1, @0,    @0, @0 ,@0],
                               @[    @6    ,     @0,     @0,    @0, @2, @0,    @0, @0 ,@0],
                               @[    @7    ,     @3    , @0,    @0, @0, @0,    @0, @0 ,@0],
                               @[    @8    ,     @2    , @0,    @0, @0, @0,    @0, @0 ,@0],
                               @[    @9    ,     @1    , @0,    @0, @0, @0,    @0, @0 ,@4]
                               ]
                           
                           ];
    
    self.validInputs = @[
                         
                         @[
                             @[@0, @0, @0,    @0, @0, @0,    @1, @7, @4],
                             @[@0, @0, @0,    @0, @0, @0,    @2, @8, @5],
                             @[@0, @0, @0,    @0, @0, @0,    @3, @9, @6],
                             
                             @[@0, @0, @0,    @1, @2, @3,    @0, @0 ,@0],
                             @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0],
                             @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0],
                             
                             @[@1, @2, @4,    @5, @6, @7,    @8, @3, @9],
                             @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0],
                             @[@0, @0, @0,    @0, @0, @0,    @0, @0 ,@0]
                          ],
                         
                         @[
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0],
                             @[@0, @0, @0, @0, @0, @0, @0, @0 ,@0]
                             ],
                         
                         @[
                             @[    @1    ,     @9    , @0, @0,     @0, @0, @0, @0 ,@8    ],
                             @[    @2    ,     @8    , @0, @0,     @9, @0, @0, @0 ,@0],
                             @[    @3    ,     @7    , @0, @0,     @0, @0, @0, @0 ,@0],
                             @[    @4    ,     @0,     @0, @0,     @0, @0, @0, @0 ,@0],
                             @[    @5    ,     @0,     @0, @0,     @1, @0, @0, @0 ,@0],
                             @[    @6    ,     @0,     @0, @0,     @2, @0, @0, @0 ,@0],
                             @[    @7    ,     @3    , @0, @0,     @0, @0, @0, @0 ,@0],
                             @[    @8    ,     @2    , @0, @0,     @0, @0, @0, @0 ,@0],
                             @[    @9    ,     @1    , @0, @0,     @0, @0, @0, @0 ,@4    ]
                             ]
                         
                         ];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testSolutionReturnsFalseForInvalidInputs {
    for(int i = 0; i < self.invalidInputs.count; i++) {
        XCTAssertFalse([self solution:self.invalidInputs[i]], @"Expected false but got true");
    }
}

-(void)testSolutionRetrunsTrueForValidInputs {
    for(int i = 0; i < self.validInputs.count; i++) {
        XCTAssertTrue([self solution:self.validInputs[i]], @"Expected false but got true");
    }
}

-(BOOL) solution:(NSArray *)input {
    NSMutableDictionary *squareToItsMembersDictionary = [NSMutableDictionary new];
    
    NSMutableArray* arrayOfColumnSets = [NSMutableArray new];
    
    NSMutableSet *currentGrid;
    
    for(int rowIndex = 0; rowIndex < input.count; rowIndex++) {
        
        NSArray *row = input[rowIndex];
        NSMutableSet *thisRowsIntegers = [NSMutableSet new];
        for(int columnIndex = 0; columnIndex < row.count; columnIndex++) {
            //first pass through, build all our column sets (each keeps track of the # in a column)
            if(rowIndex == 0) {
                arrayOfColumnSets[columnIndex] = [NSMutableSet new];
            }
            NSMutableSet *thisColumnsIntegers = arrayOfColumnSets[columnIndex];
        
            //update our current grid with where we are in the matrix
            if( (rowIndex % 3 == 0 && columnIndex == 0) || (columnIndex % 3 == 0)) {
                
                NSString *gridKey = [[[NSNumber numberWithInt:rowIndex / 3] stringValue] stringByAppendingString:[[NSNumber numberWithInt:columnIndex / 3] stringValue]];
                NSMutableSet *retrievedGrid = [squareToItsMembersDictionary objectForKey:gridKey];
    
                if(retrievedGrid){
                    currentGrid = retrievedGrid;
                }
                else {
                    currentGrid = [NSMutableSet new];
                    [squareToItsMembersDictionary setObject:currentGrid forKey:gridKey];
                }
            }
            NSNumber *currentNumber = row[columnIndex];
            //0 is undefined - doesnt count towards anything
            if(currentNumber > [NSNumber numberWithInt:0]) {

                //will find invalid columns
                if([thisColumnsIntegers containsObject:row[columnIndex]]) {
                    return NO;
                }
                else {
                    [thisColumnsIntegers addObject:row[columnIndex]];
                }

                //will find invalid rows
                if([thisRowsIntegers containsObject:row[columnIndex]]) {
                    return NO;
                }
                else {
                    [thisRowsIntegers addObject:row[columnIndex]];
                }
                
                //this will find invalid grids
                if([currentGrid containsObject:row[columnIndex]]) {
                    return NO;
                }
                else {
                    [currentGrid addObject:row[columnIndex]];
                }
            }
            
        }
        
    }
    
    return YES;
}

@end
