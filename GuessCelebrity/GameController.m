//
//  GameController.m
//  GuessCelebrity
//
//  Created by Muzahid on 1/14/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//


#import "GameController.h"
#define k_Celebriteies_Dir @"/Documents/celebrities.bin"

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
      
      if ([[NSUserDefaults standardUserDefaults]integerForKey:@"NUM_LABEL"]) {
        self.numberOfLabel = [[NSUserDefaults standardUserDefaults]integerForKey:@"NUM_LABEL"];
      }else{
        self.numberOfLabel = 1;
      }
      
        NSString *resourcePath = [[NSBundle mainBundle]pathForResource:@"Test" ofType:@"plist"];
      self.celebrities = [[NSArray alloc]initWithContentsOfFile:resourcePath];
      NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:k_Celebriteies_Dir]];
     // self.celebrityAry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
      
      if (data == nil){
        self.celebrityAry = [NSMutableArray arrayWithArray:self.celebrities];
        printf("intial %zd",self.celebrityAry.count);
      }else{
        self.celebrityAry = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        printf("old %zd",self.celebrityAry.count);
      }

    }
    return self;
}

-(void)reset{
  self.celebrityAry = [NSMutableArray arrayWithArray:self.celebrities];
  self.numberOfLabel = 1;
  [[NSUserDefaults standardUserDefaults]setInteger:self.numberOfLabel forKey:@"NUM_LABEL"];
  //[self saveCelebrities];
}

- (void)saveCelebrities{
  NSString *filename = [NSHomeDirectory() stringByAppendingString:k_Celebriteies_Dir];
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.celebrityAry];
  [data writeToFile:filename atomically:YES];
  
  [[NSUserDefaults standardUserDefaults]setInteger:self.numberOfLabel forKey:@"NUM_LABEL"];
}


@end

