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




@interface LabelViewController ()
@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationController.navigationBarHidden = YES;
  
  for (UIView *obj in self.view.subviews) {
    if ([obj isKindOfClass:[UIButton class]]) {
      if (obj.tag>= 0 && obj.tag<=8) {
        obj.layer.cornerRadius = 8;
      }
    }
    
  }
  
  [self updateUIAfterLableCompleted];
  
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newLabelUnlock:) name:k_Label_Completed object:nil];
  
}

-(void)newLabelUnlock:(NSNotification *)notification{
  [self updateUIAfterLableCompleted];

}

-(void)updateUIAfterLableCompleted{
  NSUInteger unlockLable = sharedController.numberOfLabel / k_Unlock_Interval;
  for (UIView *obj in self.view.subviews) {
    if ([obj isKindOfClass:[UIButton class]]) {
      if (obj.tag>= 0 && obj.tag<=unlockLable) {
        [(UIButton *)obj setBackgroundImage:[UIImage imageNamed:@"unlock"] forState:UIControlStateNormal];
      }else{
        [(UIButton *)obj setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
      }
    }
    
  }
}

-(void)viewDidAppear:(BOOL)animated{
  sharedController.gameStatus = YES;
 // [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
}

- (IBAction)buttonActions:(id)sender {
  
  UIButton *obj = (UIButton *)sender;
  
  NSUInteger unlockLable = sharedController.numberOfLabel / k_Unlock_Interval;
  
  
  if ( obj.tag<=unlockLable) {
    sharedController.gameStatus = YES;
    [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
  }else{
    printf("unlock");
  }
  
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
