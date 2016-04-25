//
//  GameController.m
//  GuessCelebrity
//
//  Created by Muzahid on 1/14/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//

#import "GameController.h"

@implementation GameController

+(instancetype)sharedController{
     static GameController *sharedController = nil;
     static dispatch_once_t onceToken;
    if (!sharedController) {
        dispatch_once(&onceToken, ^{
            sharedController = [[GameController alloc]init];
            
        });
    }
    return sharedController;
}

-(id)init{
    self = [super init];
    if (self) {
        self.numberOfLabel = 1;
        NSString *resourcePath = [[NSBundle mainBundle]pathForResource:@"Celebrity" ofType:@"plist"];
      self.celebrities = [[NSArray alloc]initWithContentsOfFile:resourcePath];
      
      self.celebrityAry = [NSMutableArray arrayWithArray:self.celebrities];

    }
    return self;
}

-(void)reset{
  self.celebrityAry = [NSMutableArray arrayWithArray:self.celebrities];
}
@end

