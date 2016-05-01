//
//  ViewController.h
//  GuessCelebrity
//
//  Created by Muzahid on 12/28/14.
//  Copyright (c) 2014 Muzahid. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GamePlayDelegate <NSObject>

@optional
-(void)labelCompleted:(NSUInteger) label;

@end

@interface GamePlayViewController : UIViewController

@property (weak) id<GamePlayDelegate> delegate;

@end

