//
//  GameController.h
//  GuessCelebrity
//
//  Created by Muzahid on 1/14/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameController : NSObject
@property (assign) BOOL gameStatus;  // yes play no restart
@property (assign) BOOL gameOnProgress;
@property (nonatomic, strong) NSString *celebrityName;
@property (strong) NSArray *celebrityAry;




+ (instancetype)sharedController;
- (void)reset;
-(NSUInteger)getCurrentLabel;
-(void)setCurrentLabel:(NSUInteger)label;
-(NSUInteger)unlockLabelGet;
-(void)unlockLabelSet:(NSUInteger)numberOfLabelUnlocked;
@end
