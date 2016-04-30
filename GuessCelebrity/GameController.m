//
//  GameController.m
//  GuessCelebrity
//
//  Created by Muzahid on 1/14/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//


#import "GameController.h"
#define k_Celebriteies_Dir @"/Documents/celebrities.bin"

@interface GameController()
@property (nonatomic, assign) NSUInteger myLabel;

@end
@implementation GameController
@synthesize myLabel;

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
      
        NSString *resourcePath = [[NSBundle mainBundle]pathForResource:@"Test" ofType:@"plist"];
      self.celebrityAry = [[NSArray alloc]initWithContentsOfFile:resourcePath];
      self.myLabel = 1;
     
    }
    return self;
}



-(NSUInteger)getCurrentLabel{
  
  if (self.myLabel <= 0) {
    return 1;
  }else{
    return self.myLabel;
    
  }
}

-(void)setCurrentLabel:(NSUInteger)label{
  if ( label > [self unlockLabelGet]) {
    [self unlockLabelSet:label];
  }
  self.myLabel = label;
}




-(void)reset{
 // self.celebrityAry = [NSMutableArray arrayWithArray:self.celebrities];
   [self unlockLabelSet:1];
  //[self saveCelebrities];
}

-(NSUInteger)unlockLabelGet{
  if ([[NSUserDefaults standardUserDefaults]integerForKey:@"NUM_LABEL"]) {
    return (NSUInteger)[[NSUserDefaults standardUserDefaults]integerForKey:@"NUM_LABEL"];
  }else{
    return 1;
  }
}

-(void)unlockLabelSet:(NSUInteger)numberOfLabelUnlocked{
  [[NSUserDefaults standardUserDefaults]setInteger:numberOfLabelUnlocked forKey:@"NUM_LABEL"];
}




@end

