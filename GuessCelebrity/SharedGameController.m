//
//  GameController.m
//  GuessCelebrity
//
//  Created by Muzahid on 1/14/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//

#import "SharedGameController.h"

@implementation SharedGameController

+(instancetype)sharedController{
     static SharedGameController *sharedController = nil;
     static dispatch_once_t onceToken;
    if (!sharedController) {
        dispatch_once(&onceToken, ^{
            sharedController = [[SharedGameController alloc]init];
            
        });
    }
    return sharedController;
}

-(id)init{
    self = [super init];
    if (self) {
        self.numberOfLabel = 1;
        NSString *resourcePath = [[NSBundle mainBundle]pathForResource:@"Celebrity" ofType:@"plist"];
        self.celebrityAry =  [[NSArray alloc]initWithContentsOfFile:resourcePath];

    }
    return self;
}
@end

