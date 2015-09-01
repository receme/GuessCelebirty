//
//  ImageGrid.h
//  GuessCelebrity
//
//  Created by Muzahid on 12/28/14.
//  Copyright (c) 2014 Muzahid. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageGridDelegate;

@interface ImageGrid : UIImageView

@property (weak) id<ImageGridDelegate>delegate;
-(void)reload;
@end

@protocol ImageGridDelegate <NSObject>
@required
-(void)tapOnTheView:(ImageGrid *)imageGrid atGridView:(UIView *)view ;

@end
