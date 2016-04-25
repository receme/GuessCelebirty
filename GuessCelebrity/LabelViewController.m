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
  
  for (UIButton *obj in self.view.subviews) {
    if (obj.tag>= 0 && obj.tag<=8) {
      obj.layer.cornerRadius = 8;
    }
  }
  
}

-(void)viewDidAppear:(BOOL)animated{
  sharedController.gameStatus = YES;
 // [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
}

- (IBAction)buttonActions:(id)sender {
  
  sharedController.gameStatus = YES;
  [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
