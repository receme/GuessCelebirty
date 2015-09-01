//
//  InitialViewController.m
//  GuessCelebrity
//
//  Created by Muzahid on 1/12/15.
//  Copyright (c) 2015 Muzahid. All rights reserved.
//

#import "InitialViewController.h"
#import "SharedGameController.h"
#import "Global.h"


@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UIButton *moreAppsBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *restartBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *guessCelebrityLabel;
@property (strong, nonatomic) NSTimer *animationTimer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation InitialViewController

- (IBAction)backButtonAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      
    self.textLabel.numberOfLines = self.guessCelebrityLabel.numberOfLines =0;
    self.textLabel.text = @"Tap the blocks to reveal the image";
   // self.guessCelebrityLabel.text =@"Gues The\nCelebrity";
  
    [self makeBtnRound];
}

-(void)viewDidAppear:(BOOL)animated{
    
    if (sharedController.gameOnProgress) {
        self.restartBtn.alpha = 1;
    }else{
        self.restartBtn.alpha = 0;
    }
     self.titleLabel.text = [NSString stringWithFormat:@"LEVEL %zd",sharedController.numberOfLabel];

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
    [self performSegueWithIdentifier:@"PUSH_GAME" sender:self];
}

- (IBAction)moreApsBtnAction:(id)sender {
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
