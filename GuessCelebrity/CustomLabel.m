//
//  CustomLabel.m
//  GuessCelebrity
//
//  Created by Md. Muzahidul Islam on 4/30/16.
//  Copyright © 2016 Muzahid. All rights reserved.
//

#import "CustomLabel.h"

#define kLabelHeight 20

@implementation CustomLabel

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.labelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)-kLabelHeight)];
    self.labelBtn.backgroundColor = [UIColor whiteColor];
    self.labelBtn.layer.cornerRadius = 10;
    [self addSubview:self.labelBtn];
    self.labelTag = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelBtn.frame), CGRectGetWidth(frame), kLabelHeight)];
    self.labelTag.font = [UIFont boldSystemFontOfSize:15];
    //self.labelTag.adjustsFontSizeToFitWidth = YES;
   // [self.labelTag sizeToFit];
    self.labelTag.textColor = [UIColor whiteColor];
    self.labelTag.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.labelTag];
  }
  return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
