//
//  AppDelegate.h
//  GuessCelebrity
//
//  Created by Muzahid on 12/28/14.
//  Copyright (c) 2014 Muzahid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)pauseBackgroundMusic;
-(void)playBackgroundMusic;
@end

