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
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *guessCelebrityLabel;
@property (strong, nonatomic) NSTimer *animationTimer;
@property (weak, nonatomic) IBOutlet UIButton *backGroundMusicBtn;
@property (weak, nonatomic) IBOutlet UIButton *reavealBtn;

@end

@implementation InitialViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.guessCelebrityLabel.text = kName;
  
  [self makeBtnRound];
  [self changeBackgroundMusicBtnTitle];

}

- (void)changeBackgroundMusicBtnTitle{
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Background_Sound]) {
    
//    [self.backGroundMusicBtn setTitle:@"Background Music Off" forState:UIControlStateNormal];
      [self.backGroundMusicBtn setImage:[UIImage imageNamed:@"music_on"] forState:UIControlStateNormal];
  }else{
    [self.backGroundMusicBtn setImage:[UIImage imageNamed:@"music_off"] forState:UIControlStateNormal];
  }
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(animatedButton:) userInfo:nil repeats:YES];
  
}

-(void)makeBtnRound{
  
  
  self.playBtn.layer.cornerRadius = 23;
  self.playBtn.clipsToBounds = YES;
  
  self.playBtn.layer.borderWidth = 3;
  self.playBtn.layer.borderColor= [UIColor whiteColor].CGColor;
}

#pragma mark- Button Action

- (IBAction)restartBtnAction:(id)sender {
  sharedController.gameStatus = NO;
  sharedController.gameOnProgress = NO;
  [sharedController setCurrentLabel:1];
  [_animationTimer invalidate];
  [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
}

- (IBAction)playBtnAction:(id)sender {
  sharedController.gameStatus = YES;
  [_animationTimer invalidate];
  [self performSegueWithIdentifier:@"PUSH" sender:self];
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
//    [self.reavealBtn setTitle:@"Reveal Sound On" forState:UIControlStateNormal];
      [self.reavealBtn setImage:[UIImage imageNamed:@"sound_off"] forState:UIControlStateNormal];
  }else{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:k_Reveal_Sound];
//    [self.reavealBtn setTitle:@"Reveal Sound Off" forState:UIControlStateNormal];
      [self.reavealBtn setImage:[UIImage imageNamed:@"sound_on"] forState:UIControlStateNormal];
  }
  
}

-(void)animatedButton:(NSTimer *)timer{
  [UIView animateWithDuration:0.5 animations:^{
    self.guessCelebrityLabel.layer.affineTransform =  CGAffineTransformMakeScale(0.8, 0.8);
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.5 animations:^{
      self.guessCelebrityLabel.layer.affineTransform =  CGAffineTransformIdentity;
      
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
