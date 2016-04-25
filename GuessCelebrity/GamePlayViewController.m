//
//  ViewController.m
//  GuessCelebrity
//
//  Created by Muzahid on 12/28/14.
//  Copyright (c) 2014 Muzahid. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "GamePlayViewController.h"
#import "PrepareString.h"
#import "GameController.h"
#import "Global.h"

#define k_CharSet @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define K_REVEAL_NUM 6

typedef void (^Handler)(BOOL isCompleted);

@interface GamePlayViewController ()<ImageGridDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) ImageGrid *imageGrid;
@property (nonatomic, strong) NSMutableArray *selectedCharBtnAry;
@property (nonatomic ,strong) NSMutableDictionary *frameDic;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) NSString *celebrityName;
@property (assign)  NSUInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *allBtnAry;
@property (assign) NSUInteger numbeReveal;
@property (assign) BOOL levelCompleted;
@property (nonatomic, strong) NSMutableArray *resultFrameAry;
@property (assign) NSUInteger count;


// view after completion a level
@property (weak, nonatomic) IBOutlet UIView *viewAfterCompleteLavel;
@property (weak, nonatomic) IBOutlet UIView *blackView;
@property (weak, nonatomic) IBOutlet UILabel *celebrityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *intialReveals;
@property (weak, nonatomic) IBOutlet UILabel *usedReveals;
@property (weak, nonatomic) IBOutlet UILabel *earnedCoinLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;

@property (weak, nonatomic) IBOutlet UILabel *revealLabel;
@end

@implementation GamePlayViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = kBackgroundColor;
  self.viewAfterCompleteLavel.alpha = 0;
  self.viewAfterCompleteLavel.center = CGPointMake(self.view.frame.size.width/2, -self.view.frame.size.height/2);
  
  self.navigationController.navigationBarHidden = YES;
  
  [self playAudio];
  self.imageGrid = [[ImageGrid alloc]initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, 80, 250, 250)];
  self.imageGrid.delegate = self;
  [self.view addSubview:self.imageGrid];
  
  self.frameDic = [[NSMutableDictionary alloc]init];
  self.selectedCharBtnAry =[[NSMutableArray alloc]initWithCapacity:5];
  self.allBtnAry = [[NSMutableArray alloc]init];
  self.resultFrameAry = [[NSMutableArray alloc]init];
  
  
  [self startPlay];
  
  [self viewOrientation];
  
  
  
}

-(void)animationAfterCompletionLevel{
  self.usedReveals.text = [NSString stringWithFormat:@"Used Reveals %zd",K_REVEAL_NUM- self.numbeReveal];
  self.intialReveals.text = [NSString stringWithFormat:@"Initial Reveals %zd",K_REVEAL_NUM];
  
  self.viewAfterCompleteLavel.alpha = 1;
  [self.view bringSubviewToFront:self.viewAfterCompleteLavel];
  
  [UIView animateWithDuration:1.0 animations:^{
    self.viewAfterCompleteLavel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
  } completion:^(BOOL finished) {
    // [self.view sendSubviewToBack:self.viewAfterCompleteLavel];
  }];
  
}


-(void)viewOrientation{
  
  self.blackView.layer.cornerRadius = 4;
  self.blackView.layer.borderWidth = 1;
  self.blackView.clipsToBounds = YES;
  self.blackView.layer.borderColor = [UIColor whiteColor].CGColor;
  
  self.blackView.layer.masksToBounds = NO;
  self.blackView.layer.shadowColor = [UIColor whiteColor].CGColor;
  self.blackView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
  self.blackView.layer.shadowOpacity =1.0f;
  
  self.continueBtn.layer.cornerRadius = 23;
  self.continueBtn.layer.borderWidth = 3;
  self.continueBtn.clipsToBounds = YES;
  self.continueBtn.layer.borderColor = [UIColor whiteColor].CGColor;
  
  
}

-(void)startPlay{
  
  if ( sharedController.celebrityAry.count == 0) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulation!!" message:@"You Have Completed All Level" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      sharedController.numberOfLabel = 1;
      sharedController.gameOnProgress = NO;
      [sharedController reset];
      [self.navigationController popViewControllerAnimated:YES];
      
    }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
  }else{
    self.numbeReveal = K_REVEAL_NUM;
    self.revealLabel.text = [NSString stringWithFormat:@"%zd Reveals left",self.numbeReveal];
    self.levelCompleted = NO;
    
    
    NSUInteger index = [self getRandomNumberBetween:0 to:sharedController.celebrityAry.count-1];
  
    self.celebrityName = [sharedController.celebrityAry objectAtIndex:index];
    self.titleLabel.text = [NSString stringWithFormat:@"LEVEL %zd",sharedController.numberOfLabel];
    sharedController.gameOnProgress = YES;
    
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.celebrityName]];
    if (image) {
      self.imageGrid.image = image;
    }else{
      NSLog(@"Image Not Found...");
    }
    
    [self charBtnPuzzleView];
    [self reset];
    
    
  }
  
}

-(NSUInteger)getRandomNumberBetween:(NSUInteger)from to:(NSUInteger)to {
  
  return (NSUInteger)from + arc4random() % (to-from+1);
}

-(void)reset{
  
  [self.selectedCharBtnAry removeAllObjects];
  
  for (int i = 0; i<[self.celebrityName length]; i++) {
    [self.selectedCharBtnAry addObject:@""];
    
  }
  
  // Frame set for image
  
  [self.resultFrameAry removeAllObjects];
  
  NSUInteger numOfCharcter = [self.celebrityName length];
  
  float xPos = ((kScreenWidth-((numOfCharcter*kGridSize)+((numOfCharcter-1)*kSpace)))/2)+(kGridSize/2);
  CGPoint location = CGPointMake(xPos,kYpos);
  
  NSValue  *value = [NSValue valueWithCGPoint:location];
  [self.resultFrameAry addObject:value];
  for (int i = 1; i<numOfCharcter; i++) {
    xPos = xPos+ kGridSize + numOfCharcter;
    location = CGPointMake(xPos,kYpos);
    value = [NSValue valueWithCGPoint:location];
    [self.resultFrameAry addObject:value];
  }
  
}

-(void)charBtnPuzzleView{
  
  float xPos = (self.view.frame.size.width-((6*kGridSize)+(5*5)))/2;
  PrepareString *obj = [[PrepareString alloc]init];
  NSString *puzzleString = [obj makeResultStingFromString:self.celebrityName];
  int count = 0;
  
  if ([self.allBtnAry count]) {
    for (UILabel *tapLabel in self.allBtnAry) {
      [tapLabel removeFromSuperview];
    }
  }
  
  
  for (int i = 0; i<2; i++) {
    for (int j = 0; j<6; j++) {
      
      UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(xPos+(j*kGridSize)+(j*5), self.imageGrid.frame.size.height+80+70+(i*kGridSize+(i*5)), kGridSize, kGridSize)];
      tempLabel.textColor = [UIColor blackColor];
      tempLabel.userInteractionEnabled = YES;
      tempLabel.font = [UIFont systemFontOfSize:20];
      tempLabel.textAlignment = NSTextAlignmentCenter;
      tempLabel.layer.masksToBounds = YES;
      tempLabel.layer.cornerRadius = kGridSize/2;
      tempLabel.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:201.0f/255.0f blue:68.0f/255.0f alpha:1];
      tempLabel.text = [NSString stringWithFormat:@"%c",[puzzleString characterAtIndex:count]];
      tempLabel.tag = [[NSString stringWithFormat:@"%d%d",i,j]intValue];
      [self.frameDic setObject:[NSValue valueWithCGRect:tempLabel.frame] forKey:[NSString stringWithFormat:@"%d",(int)tempLabel.tag]];
      UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapOnCharacter:)];
      [tempLabel addGestureRecognizer:tapGesture];
      [self.view addSubview:tempLabel];
      [self.allBtnAry addObject:tempLabel];
      count++;
      
    }
    
  }
  
}

#pragma mark - Button Action
- (IBAction)backButtonAction:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)continueBtnAction:(id)sender {
  
  [UIView animateWithDuration:0.5 animations:^{
    self.viewAfterCompleteLavel.center = CGPointMake(self.view.frame.size.width/2, -self.view.frame.size.height/2);
  } completion:^(BOOL finished) {
    self.viewAfterCompleteLavel.alpha = 0;
    sharedController.numberOfLabel = sharedController.numberOfLabel+1;
    sharedController.gameStatus = YES;
    [self.audioPlayer play];
    [self.imageGrid reload];
    [self startPlay];
    
  }];
}

- (IBAction)resetBtnAction:(id)sender {
  
  [self.selectedCharBtnAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    
    if ([obj isKindOfClass:[UILabel class]]) {
      [self animateView:(UILabel*)obj withFlag:NO];
      
    }
  }];
  [self reset];
  
}

- (IBAction)shareButtonAction:(id)sender {
  UIImage *imageExport=[self screenshot];
  
  NSArray *ary=@[imageExport];
  UIActivityViewController *activityVC=[[UIActivityViewController alloc]initWithActivityItems:ary applicationActivities:nil];
  [self presentViewController:activityVC animated:YES completion:nil];
  
}


-(UIImage*)screenshot
{
  
  UIGraphicsBeginImageContext(self.view.frame.size);
  
  [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *saveImg = UIGraphicsGetImageFromCurrentImageContext();
  NSData *imageData = UIImagePNGRepresentation(saveImg);
  UIImage* imageExport=[UIImage imageWithData:imageData];
  
  UIGraphicsEndImageContext();
  
  return imageExport;
}

#pragma mark - Handle Tap on Character
-(void)handleTapOnCharacter:(UITapGestureRecognizer *)tapGesture{
  
  UILabel *tapLabel = (UILabel*)[tapGesture view];
  [self handleResultSequence:tapLabel];
  
}

-(void)handleResultSequence:(UILabel *)tapLabel{
  
  
  __block  CGPoint point;
  __block NSUInteger index;
  
  if (![self.selectedCharBtnAry containsObject:tapLabel]) {
    
    self.count ++;
    [self.selectedCharBtnAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      
      if ([obj isKindOfClass:[NSString class]]) {
        index = idx;
        *stop = YES;
      }
    }];
    
    [self.selectedCharBtnAry replaceObjectAtIndex:index withObject:tapLabel];
    NSValue *value = [self.resultFrameAry objectAtIndex:index];
    point = value.CGPointValue;
    
  }else{
    self.count --;
    index = [self.selectedCharBtnAry indexOfObject:tapLabel];
    [self.selectedCharBtnAry replaceObjectAtIndex:index withObject:@""];
    NSValue *value = [self.frameDic objectForKey:[NSString stringWithFormat:@"%d",(int)tapLabel.tag]];
    CGRect frame = value.CGRectValue;
    point = CGPointMake(CGRectGetMidX(frame),CGRectGetMidY(frame));
    
    
  }
  
  
  [UIView animateWithDuration:0.3 animations:^{
    tapLabel.center = point;
    [self playAudio];
  } completion:^(BOOL finished) {
    [self shakAnimation:tapLabel];
  }];
  
  if (index == self.celebrityName.length-1) {
    [self analysisResultWithCompletion:^(BOOL isCompleted) {
      if (isCompleted) {
        [self handleWin];
      }else{
        [self performSelector:@selector(resetBtnAction:) withObject:nil];
        
      }
    }];
    
  }
  
}



#pragma mark - Check For the matching

-(void)analysisResultWithCompletion:(Handler)handler{
  
  NSMutableString *resultString = [[NSMutableString alloc]init];
  [self.selectedCharBtnAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:[UILabel class]]) {
      UILabel *tapLabel = (UILabel*)obj;
      [resultString appendString:tapLabel.text];
      
    }
  }];
  
  if ([resultString isEqualToString:self.celebrityName]) {
    NSLog(@"win...");
    self.levelCompleted = YES;
    if ([sharedController.celebrityAry containsObject:self.celebrityName]) {
      [sharedController.celebrityAry removeObject:self.celebrityName];
    }
    handler(YES);
    
  }else{
    
    [self playAudio];
    
    [self.selectedCharBtnAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      UILabel *tapLabel;
      if ([obj isKindOfClass:[UILabel class]]) {
        tapLabel = (UILabel*)obj;
      }
      
      [UIView animateKeyframesWithDuration:0.1 delay:0.3 options:UIViewKeyframeAnimationOptionAutoreverse animations:^{
        tapLabel.alpha = 0;
        tapLabel.backgroundColor = [UIColor redColor];
        
      } completion:^(BOOL finished) {
        tapLabel.alpha = 1;
        tapLabel.backgroundColor = [UIColor colorWithRed:237.0f/255.0f green:201.0f/255.0f blue:68.0f/255.0f alpha:1];
      }];
      if (idx == self.celebrityName.length - 1) {
        handler(NO);
      }
      
    }];
    
    
  }
  
}

#pragma mark - Handle After Completed A Level

-(void)handleWin{
  
  [UIView animateKeyframesWithDuration:0.5 delay:0.5 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
    [self.imageGrid.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      UIImageView *imageView = (UIImageView*)obj;
      
      [self tapOnTheView:self.imageGrid atGridView:imageView];
    }];
    
  } completion:^(BOOL finished) {
    self.celebrityNameLabel.text = self.celebrityName;
    [self animationAfterCompletionLevel];
  }];
  
  
}

#pragma mark- Handle Animation


-(void)animateView:(UILabel*)tapLabel withFlag:(BOOL)flag{
  
  CGPoint point;
  NSValue *value = [self.frameDic objectForKey:[NSString stringWithFormat:@"%d",(int)tapLabel.tag]];
  CGRect frame = value.CGRectValue;
  point = CGPointMake(CGRectGetMidX(frame),CGRectGetMidY(frame));
  
  [UIView animateWithDuration:0.3 animations:^{
    tapLabel.center = point;
    [self playAudio];
  } completion:^(BOOL finished) {
    [self shakAnimation:tapLabel];
  }];
  
  
}

#pragma mark Shake Animaition
-(void)shakAnimation:(UIView*)lockView{
  
  CABasicAnimation *animation =
  [CABasicAnimation animationWithKeyPath:@"position"];
  [animation setDuration:0.009];
  [animation setRepeatCount:3];
  [animation setAutoreverses:YES];
  [animation setFromValue:[NSValue valueWithCGPoint:
                           CGPointMake([lockView center].x , [lockView center].y- 5.0f)]];
  [animation setToValue:[NSValue valueWithCGPoint:
                         CGPointMake([lockView center].x, [lockView center].y + 5.0f)]];
  [[lockView layer] addAnimation:animation forKey:@"position"];
}

#pragma mark - ImageGrid Delegate

-(void)tapOnTheView:(ImageGrid *)imageGrid atGridView:(UIView *)view{
  
  if (!self.levelCompleted) {
    if (self.numbeReveal == 0) {
      return;
    }else{
      self.numbeReveal--;
      self.revealLabel.text = [NSString stringWithFormat:@"%zd Reveals left",self.numbeReveal];
      
    }
  }
  
  UIView *tempView = view;
  tempView.frame = CGRectMake(view.frame.origin.x+(self.view.frame.size.width-255)/2, view.frame.origin.y+50, 45, 45);
  [self.view addSubview:tempView];
  CABasicAnimation* rotationAnimation = [self rotationInitialization];
  
  [UIView animateWithDuration:0.8 animations:^{
    [self playAudio];
    [tempView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    tempView.frame = CGRectMake(view.frame.origin.x, self.view.frame.size.height, view.frame.size.width, view.frame.size.height);
    
  } completion:^(BOOL finished) {
    [tempView removeFromSuperview];
  }];
  
}

#pragma mark - 360 Rotation View
-(CABasicAnimation *)rotationInitialization{
  
  CABasicAnimation* rotationAnimation;
  rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
  rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 10.0f * 0.5 ];
  rotationAnimation.duration = 1.0f;
  rotationAnimation.cumulative = YES;
  rotationAnimation.repeatCount = 5;
  return rotationAnimation;
}

#pragma mark - Play Audio
-(void)playAudio{
  
  NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"tap-sound" ofType: @"mp3"];
  NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
  if (!self.audioPlayer) {
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    self.audioPlayer.numberOfLoops = 0;
  }
  if ([[NSUserDefaults standardUserDefaults]boolForKey:k_Reveal_Sound]) {
    [self.audioPlayer play];
  }
  
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
