//
//  Global.h
//  GuessCelebrity
//
//  Created by Muzahid on 1/2/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//
#import "AppDelegate.h"
#import "ImageGrid.h"
#define kGridSize 40

#define kBackgroundColor [UIColor colorWithRed:0.89f green:0.274f blue:0.247f alpha:1]
#define kScreenWidth [[UIScreen mainScreen] applicationFrame].size.width
#define kSpace 5
#define kXpos ((kScreenWidth-((5*kGridSize)+(4*kSpace)))/2)+(kGridSize/2)
#define kYpos 375
//#define kFistLocation CGPointMake(kXpos,kYpos)
//#define kSecondLocation CGPointMake(kFistLocation.x+kGridSize+5,kYpos)
//#define kThirdLocation CGPointMake(kSecondLocation.x+kGridSize+5,kYpos)
//#define kFourthLocation CGPointMake(kThirdLocation.x+kGridSize+5,kYpos)
//#define kFifthLocation CGPointMake(kFourthLocation.x+kGridSize+5,kYpos)
//#define kSixthLocation CGPointMake(kFifthLocation.x+kGridSize+5,kYpos)
//
#define sharedController [GameController sharedController]

#define appdelegate (AppDelegate*)[[UIApplication sharedApplication]delegate]

#define k_Reveal_Sound @"ReavelSound"

#define k_Background_Sound @"BackGroundSound"

#define k_Unlock_Interval 3 // after the period the label become onlock

#define k_Label_Completed @"New_Label_Completed"
