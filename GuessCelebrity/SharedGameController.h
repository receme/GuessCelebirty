//
//  GameController.h
//  GuessCelebrity
//
//  Created by Muzahid on 1/14/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedGameController : NSObject
@property (assign) BOOL gameStatus;  // yes play no restart
@property (assign) BOOL gameOnProgress;
@property (assign) NSUInteger numberOfLabel;
@property (assign) NSUInteger numberOfCoin;
@property (nonatomic, strong) NSString *celebrityName;
@property (strong) NSArray *celebrityAry;

+(instancetype)sharedController;
@end
