//
//  LabelViewController.m
//  GuessCelebrity
//
//  Created by Md. Muzahidul Islam on 4/24/16.
//  Copyright © 2016 Muzahid. All rights reserved.
//

#import "LabelViewController.h"
#import "GameController.h"
#import "Global.h"

#define k_Button_Dimension 100
#define k_space 20

@interface LabelViewController ()

@property (nonatomic,strong) UIScrollView *scroller;

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationController.navigationBarHidden = YES;

  
  /*
             k_space
             #### k_Button_Dimension
             k_space
             #### k_Button_Dimension
             k_space
             #### k_Button_Dimension
             k_space
   */
  
  NSUInteger scrollerHeight = k_space+k_Button_Dimension+k_space+k_Button_Dimension+k_space+k_Button_Dimension+k_space;
  
  self.scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), scrollerHeight)];
  [self.view addSubview:self.scroller];
  
  
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newLabelUnlock:) name:k_Label_Completed object:nil];
  
  [self reloadScroller];
}

-(void)reloadScroller{
  
  // remove if any exist previous subviews
  [self.scroller.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [obj removeFromSuperview];
  }];
  
  NSUInteger tag = 1;
  
  for (int i = 0; i< 3; i++) {
    for (int j = 0; j< 10; j++) {
      CGFloat xPos = ((j+1)*k_space) + (j*k_Button_Dimension);
      CGFloat yPos =  ((i+1)*k_space) + (i*k_Button_Dimension);
      UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(xPos, yPos, k_Button_Dimension, k_Button_Dimension)];
      NSString *imageName = tag > [sharedController unlockLabelGet] ? @"lock" : @"unlock";
      [btn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
      btn.tag = tag;
      [btn setBackgroundColor:[UIColor whiteColor]];
      [btn.layer setCornerRadius:4];
      [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
      tag++;
      [self.scroller addSubview:btn];
      
    }
  }
  
  [self.scroller setContentSize:CGSizeMake((10*k_Button_Dimension)+(11*k_space), (3*k_Button_Dimension)+(4*k_space))];
  
}
-(void)tap:(UIButton *)sender{
  
  if (sender.tag <= [sharedController unlockLabelGet] ) {
   [sharedController setCurrentLabel:sender.tag];
   // sharedController.current = sender.tag;
    [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
  }
  
}

-(void)newLabelUnlock:(NSNotification *)notification{
  [self reloadScroller];

}


-(void)viewDidAppear:(BOOL)animated{
  sharedController.gameStatus = YES;
 // [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
