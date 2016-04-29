//
//  InstructionViewController.m
//  GuessCelebrity
//
//  Created by Md. Muzahidul Islam on 4/29/16.
//  Copyright © 2016 Muzahid. All rights reserved.
//

#import "InstructionViewController.h"
#import "Global.h"

@interface InstructionViewController ()

@end

@implementation InstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.view setBackgroundColor:kBackgroundColor];
    // Do any additional setup after loading the view.
}
- (IBAction)doneAction:(id)sender {
  
  [self dismissViewControllerAnimated:true completion:nil];
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
