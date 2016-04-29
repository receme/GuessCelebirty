//
//  InitialViewController.m
//  GuessCelebrity
//
//  Created by Muzahid on 1/12/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//

#import "InitialViewController.h"
#import "GameController.h"
#import "Global.h"
#import "LabelViewController.h"



@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UIButton *moreAppsBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *restartBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessCelebrityLabel;
@property (strong, nonatomic) NSTimer *animationTimer;
@property (weak, nonatomic) IBOutlet UIButton *backGroundMusicBtn;
@property (weak, nonatomic) IBOutlet UIButton *reavealBtn;

@end

@implementation InitialViewController

- (IBAction)backButtonAction:(id)sender {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  
  [self makeBtnRound];
  
  [self changeBackgroundMusicBtnTitle];
  
  // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveCurrentState) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)saveCurrentState{
  printf("save state");
  [sharedController saveCelebrities];
}

- (void)changeBackgroundMusicBtnTitle{
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Background_Sound]) {
    
    [self.backGroundMusicBtn setTitle:@"Background Music Off" forState:UIControlStateNormal];
  }else{
    [self.backGroundMusicBtn setTitle:@"Background Music On" forState:UIControlStateNormal];
  }
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(animatedButton:) userInfo:nil repeats:YES];
  
}
-(void)makeBtnRound{
  
  
  self.moreAppsBtn.layer.cornerRadius = self.playBtn.layer.cornerRadius =self.restartBtn.layer.cornerRadius= 23;
  
  self.moreAppsBtn.clipsToBounds=self.playBtn.clipsToBounds=self.restartBtn.clipsToBounds = YES;
  
  self.moreAppsBtn.layer.borderWidth = self.playBtn.layer.borderWidth = self.restartBtn.layer.borderWidth = 3;
  self.moreAppsBtn.layer.borderColor=self.playBtn.layer.borderColor=self.restartBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

#pragma mark- Button Action

- (IBAction)restartBtnAction:(id)sender {
  sharedController.gameStatus = NO;
  sharedController.gameOnProgress = NO;
  sharedController.numberOfLabel = 1;
  [_animationTimer invalidate];
  [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
}

- (IBAction)playBtnAction:(id)sender {
  sharedController.gameStatus = YES;
  [_animationTimer invalidate];
  [self performSegueWithIdentifier:@"PUSH" sender:self];
  //  UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  //  LabelViewController *obj = [main instantiateViewControllerWithIdentifier:@"LABEL_VC"];
  //  [self.navigationController pushViewController:obj animated:YES];
  //  [self performSegueWithIdentifier:@"LABEL_VC" sender:self];
}

- (IBAction)moreApsBtnAction:(id)sender {
  
}

- (IBAction)backgroundSoundOffbtnAction:(id)sender {
  
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Background_Sound]) {
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:k_Background_Sound];
    [self changeBackgroundMusicBtnTitle];
    [appdelegate pauseBackgroundMusic];
    
  }else{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:k_Background_Sound];
    [self changeBackgroundMusicBtnTitle];
    [appdelegate playBackgroundMusic];
    
  }
  
  
}

- (IBAction)tapSoundOff:(id)sender {
  
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Reveal_Sound]) {
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:k_Reveal_Sound];
    [self.reavealBtn setTitle:@"Reveal Sound On" forState:UIControlStateNormal];
  }else{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:k_Reveal_Sound];
    [self.reavealBtn setTitle:@"Reveal Sound Off" forState:UIControlStateNormal];
  }
  
  //[appdelegate playBackgroundMusic];
}

-(void)animatedButton:(NSTimer *)timer{
  [UIView animateWithDuration:0.5 animations:^{
    self.moreAppsBtn.layer.affineTransform=self.playBtn.layer.affineTransform=self.restartBtn.layer.affineTransform = self.guessCelebrityLabel.layer.affineTransform =  CGAffineTransformMakeScale(0.8, 0.8);
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5 animations:^{
      self.moreAppsBtn.layer.affineTransform=self.playBtn.layer.affineTransform=self.restartBtn.layer.affineTransform = self.guessCelebrityLabel.layer.affineTransform =  CGAffineTransformIdentity;
      
    }];
  }];
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
