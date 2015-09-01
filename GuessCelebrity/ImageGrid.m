//
//  ImageGrid.m
//  GuessCelebrity
//
//  Created by Muzahid on 12/28/14.
//  Copyright (c) 2014 Muzahid. All rights reserved.
//

#import "ImageGrid.h"

@implementation ImageGrid
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //self.image = [UIImage imageNamed:@"rolando.jpeg"];
        self.userInteractionEnabled = YES;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4.0;
        self.layer.borderWidth = 2.0f;
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        [self reload];
    }
    return self;
}

-(void)reload{
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    float dimensoin = 50.0f;
    int tag = 0;
    
    for (int i = 0; i<5; i++){
        for (int j= 0; j<5; j++) {
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake((j*dimensoin),(i*dimensoin), dimensoin, dimensoin)];
          //  view.backgroundColor = [UIColor blueColor];
            view.image = [UIImage imageNamed:@"grid.jpg"];
            view.userInteractionEnabled = YES;
            //[UIColor colorWithRed:1 green:0.1687 blue:0.388 alpha:1];
            //[UIColor darkGrayColor];
            
          //  view.layer.masksToBounds = YES;
            //view.layer.cornerRadius = 4.0;
            view.tag = tag;
            tag++;
            [self addSubview:view];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
            [view addGestureRecognizer:tapGesture];
        }
    }
}

-(void)handleTapGesture:(UITapGestureRecognizer *)gesture{
    UIView *view = [gesture view];
    if (delegate == nil) {
        return;
    }else{
        [delegate tapOnTheView:self atGridView:view];
    }
    
}
@end
