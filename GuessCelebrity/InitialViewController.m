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
#import "iAd/ADInterstitialAd.h"



@interface InitialViewController ()<ADInterstitialAdDelegate>
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *guessCelebrityLabel;
@property (strong, nonatomic) NSTimer *animationTimer;
@property (weak, nonatomic) IBOutlet UIButton *backGroundMusicBtn;
@property (weak, nonatomic) IBOutlet UIButton *reavealBtn;

@end

@implementation InitialViewController{
  ADInterstitialAd* _interstitial;
  BOOL _requestingAd;
  UIView *_adView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.guessCelebrityLabel.text = kName;
  
  [self makeBtnRound];
  [self changeBackgroundMusicBtnTitle];
  //[self showFullScreenAd];
}



- (void)changeBackgroundMusicBtnTitle{
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Background_Sound]) {
    
    [self.backGroundMusicBtn setImage:[UIImage imageNamed:@"music_on"] forState:UIControlStateNormal];
  }else{
    [self.backGroundMusicBtn setImage:[UIImage imageNamed:@"music_off"] forState:UIControlStateNormal];
  }
  
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Reveal_Sound]) {
    [self.reavealBtn setImage:[UIImage imageNamed:@"sound_on"] forState:UIControlStateNormal];
  }else{
    [self.reavealBtn setImage:[UIImage imageNamed:@"sound_off"] forState:UIControlStateNormal];
  }

  
}

-(void)viewDidAppear:(BOOL)animated{
  
 // [self showFullScreenAd];
  
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

#pragma mark Interstitial Ad
-(void)showFullScreenAd {
  if (_requestingAd == NO) {
    _interstitial = [[ADInterstitialAd alloc] init];
    _interstitial.delegate = self;
    NSLog(@"Ad Request");
    _requestingAd = YES;
  }
}

-(void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
  _requestingAd = NO;
  NSLog(@"Ad didFailWithERROR");
  NSLog(@"%@", error);
}

-(void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd {
  NSLog(@"Ad DidLOAD");
  NSLog(@"Ad DidLOAD");
  if (interstitialAd.loaded) {
    
    CGRect interstitialFrame = self.view.bounds;
    interstitialFrame.origin = CGPointMake(0, 0);
    _adView = [[UIView alloc] initWithFrame:interstitialFrame];
    [self.view addSubview:_adView];
    
    [_interstitial presentInView:_adView];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(closeAd:) forControlEvents:UIControlEventTouchDown];
    button.backgroundColor = [UIColor clearColor];
    [button setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    [_adView addSubview:button];
    
    [UIView beginAnimations:@"animateAdBannerOn" context:nil];
    [UIView setAnimationDuration:1];
    [_adView setAlpha:1];
    [UIView commitAnimations];
    
  }
}

-(void)closeAd:(id)sender {
  [UIView beginAnimations:@"animateAdBannerOff" context:nil];
  [UIView setAnimationDuration:1];
  [_adView setAlpha:0];
  [UIView commitAnimations];
  
  _adView=nil;
  _requestingAd = NO;
}


-(void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd {
  _requestingAd = NO;
  NSLog(@"Ad DidUNLOAD");
}

-(void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd {
  _requestingAd = NO;
  NSLog(@"Ad DidFINISH");
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
