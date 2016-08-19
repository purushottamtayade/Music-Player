//
//  ViewController.h
//  PTMusic Player
//
//  Created by Student P_06 on 08/08/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController{
    AVAudioPlayer *audioPlayer;
    NSTimer *durationTimer;
    NSArray *songList;
    AVAudioRecorder *audioRecorder;
    
}

@property (weak, nonatomic) IBOutlet UISlider *sliderMusic;
@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;
@property (weak, nonatomic) IBOutlet UIButton *buttonStop;
@property (weak, nonatomic) IBOutlet UIButton *buttonRecord;
@property (weak, nonatomic) IBOutlet UISlider *sliderVOLUME;
- (IBAction)playButtonTapped:(id)sender;
- (IBAction)stopButtonTapped:(id)sender;
- (IBAction)recordButtonTapped:(id)sender;
- (IBAction)volumeSlider:(id)sender;
- (IBAction)musicSlider:(id)sender;
- (IBAction)previousButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;

-(NSString *)previousSong;
@end

