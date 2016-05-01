//
//  AppDelegate.m
//  GuessCelebrity
//
//  Created by Muzahid on 12/28/14.
//  Copyright (c) 2014 Muzahid. All rights reserved.
//

#import "AppDelegate.h"
#import "GameController.h"
#import "Global.h"

@interface AppDelegate ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
  
  if (![[NSUserDefaults standardUserDefaults]boolForKey:@"FRIST_TIME"]) {
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:k_Background_Sound];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:k_Reveal_Sound];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"FRIST_TIME"];
  }
  
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   [self pauseBackgroundMusic];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Background_Sound]) {
  
    [self playBackgroundMusic];

    
  }else{
    
    [self pauseBackgroundMusic];

  }

}

- (void)handleBackgorundSound:(NSNotification *) notification{
  
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
 
}

-(void)pauseBackgroundMusic{
  
  if (self.audioPlayer.isPlaying) {
    [self.audioPlayer pause];
  }
  
}

- (void)playBackgroundMusic{
  
//  try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//  try AVAudioSession.sharedInstance().setActive(true)
  [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
  [[AVAudioSession sharedInstance]setActive:YES error:nil];
  
  NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"background_music2" ofType: @"wav"];
  NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
  if (!self.audioPlayer) {
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    self.audioPlayer.numberOfLoops = -1;
  }
  [self.audioPlayer play];
}

@end
