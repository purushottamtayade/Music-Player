//
//  ViewController.m
//  PTMusic Player
//
//  Created by Student P_06 on 08/08/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

unsigned int count;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sliderMusic.value = 0.0;
    songList = [[NSArray alloc]initWithObjects:@"Mitwaa",@"FlyingJatt",@"MitwaaCopy", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playButtonTapped:(id)sender {
    UIButton *button = sender;
    if ([button.titleLabel.text isEqualToString:@"Play"]) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        [button setTitle:@"Pause" forState:UIControlStateNormal];
        
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[[NSBundle mainBundle]URLForResource:@"Mitwaa" withExtension:@"mp3"] error:&error];
        count = 0;

        durationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateDurationSlider:) userInfo:nil repeats:YES];
        self.sliderMusic.maximumValue = audioPlayer.duration;
        if(error)
        {
            NSLog(@"%@",error.localizedDescription);
        }
        else{
            [audioPlayer play];
        }
    }
        else if([button.titleLabel.text isEqualToString:@"Pause"]) {
            
            [self.view setBackgroundColor:[UIColor grayColor]];
            
            [button setTitle:@"Resume" forState:UIControlStateNormal];
            
            if (audioPlayer) {
                [audioPlayer pause];
            }
        }
        else if ([button.titleLabel.text isEqualToString:@"Resume"]) {
            
            [self.view setBackgroundColor:[UIColor whiteColor]];

            
            [button setTitle:@"Pause" forState:UIControlStateNormal];
            if (audioPlayer) {
                [audioPlayer play];
            }
        }

        
}

- (IBAction)stopButtonTapped:(id)sender {
    if (audioPlayer) {
        [audioPlayer stop];
        audioPlayer = nil;
        [self.buttonPlay setTitle:@"Play" forState:UIControlStateNormal];
        self.sliderMusic.value = 0.0;
        
    }
    [self.view setBackgroundColor:[UIColor blackColor]];

}

-(NSURL *)urlForRecordedAudio {
    
    
    
    NSString *recordedAudioPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/record.caf"];
    
    
    NSURL *url = [NSURL URLWithString:recordedAudioPath];
    
    return url;
}


- (IBAction)recordButtonTapped:(id)sender {
    UIButton *button = sender;
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    if ([button.titleLabel.text isEqualToString:@"Record"]) {
        [button setTitle:@"Stop Record" forState:UIControlStateNormal];
        
        NSMutableDictionary *recorderSettings = [[NSMutableDictionary alloc]init];
        
        [recorderSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recorderSettings setValue:[NSNumber numberWithFloat:9500.0] forKey:AVSampleRateKey];
        [recorderSettings setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        [recorderSettings setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
        [recorderSettings setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recorderSettings setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recorderSettings setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
        
        
        NSError *error;
        audioRecorder = [[AVAudioRecorder alloc]initWithURL:[self urlForRecordedAudio] settings:recorderSettings error:&error];
        
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }
        else {
            
            [audioRecorder record];
        }
        
        
        
    }
    else if ([button.titleLabel.text isEqualToString:@"Stop Record"]) {
        [button setTitle:@"Record" forState:UIControlStateNormal];
        
        if (audioRecorder) {
            [audioRecorder stop];
        }
        
    }

}

- (IBAction)volumeSlider:(id)sender {
    UISlider *slider = sender;
    audioPlayer.volume = slider.value;
}

- (IBAction)musicSlider:(id)sender {
    UISlider *slider = sender;
    
    if (audioPlayer) {
        [audioPlayer pause];
        
        audioPlayer.currentTime = slider.value;
        
        [audioPlayer play];
    }

}

- (IBAction)previousButtonTapped:(id)sender {
    UIButton *button = sender;
    
    if([button.titleLabel.text isEqualToString:@"<|"])
    {
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[[NSBundle mainBundle]URLForResource:[self previousSong] withExtension:@"mp3"] error:&error];
        [audioPlayer play];
        [self.view setBackgroundColor:[UIColor whiteColor]];

    }

}

-(NSString *)previousSong{
    
    NSString *song;
    NSLog(@"%d",count);
    count--;
if(count >=0 && count<= songList.count)
{
song = [songList objectAtIndex:count];
}
else{
        song = [songList objectAtIndex:0];
    count++;
}
    return song;
    
}

-(NSString *)nextSong{
    
    NSString *song;
    count++;

    NSLog(@"%d",count);
    if(count<=songList.count)
    {
    song = [songList objectAtIndex:count];
    
    }
    else{
        song = [songList objectAtIndex:songList.count-1];
        count--;
    }
    return song;
    
}


- (IBAction)nextButtonTapped:(id)sender {
    UIButton *button = sender;
    
    if([button.titleLabel.text isEqualToString:@"|>"])
    {
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[[NSBundle mainBundle]URLForResource:[self nextSong] withExtension:@"mp3"] error:&error];
        [audioPlayer play];
        [self.view setBackgroundColor:[UIColor whiteColor]];

    }
    

}
-(void)updateDurationSlider:(id)sender {
    
    self.sliderMusic.value = audioPlayer.currentTime;
}
@end
