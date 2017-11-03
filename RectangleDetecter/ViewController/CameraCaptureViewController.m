//
//  ViewController.m
//  RectangleDetecter
//
//  Created by yuki on 2017/10/29.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "CameraCaptureViewController.h"
#import "DetectRectangle.h"
#import "TrackRectangle.h"

@interface CameraCaptureViewController (){
    
    VNRectangleObservation      *lastObservation;

    
    CGRect                      *lastRect;
    BOOL                        trackingFlag;
    
    dispatch_queue_t            main_queue;
    dispatch_queue_t            other_queue;
    
    VideoInput                  *videoInput;
    DetectRectangle             *detectRectangle;
    TrackRectangle              *trackRectangle;
}

- (void)setupAndStartAVCaptureSettion;

@end

@implementation CameraCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    videoInput = [[VideoInput alloc] init];
    videoInput.videoInputDelegate = self;
    
    _rectView = [[DrawRectView alloc] initWithFrame:_imageView.frame];
    [self.view addSubview:_rectView];
    [self setupAndStartAVCaptureSettion];
    
    detectRectangle = [[DetectRectangle alloc] init];
    trackRectangle = [[TrackRectangle alloc] init];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ----- Delegate Method -----
- (void)getVideoCaptureCIImage:(CIImage *)captureCIImage{
    
    /* Viewにカメラ画像を表示 */
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = [UIImage imageWithCIImage:captureCIImage];
    });
    
    // 新しい画像サイズ
    CGSize newSize = CGSizeMake(480, 640);
    CGRect ciImageRect = captureCIImage.extent;
    CGPoint scale = CGPointMake(newSize.width  / ciImageRect.size.width,
                                newSize.height / ciImageRect.size.height);
    
    CIImage *resizeCIImage = [captureCIImage imageByApplyingTransform:CGAffineTransformMakeScale(scale.x,scale.y)];
    
    NSArray *pointArray = nil;
    if (trackingFlag == NO){
        
        pointArray = [detectRectangle detectRectanglePointWithCIImage:resizeCIImage frame:_imageView.frame];
    }
    else{
        
        [trackRectangle setObservation:detectRectangle.observation];
        pointArray = [trackRectangle trackRectanglePointWithCIImage:resizeCIImage frame:_imageView.frame];
    }
    
    if (pointArray != nil){
        [_rectView setQuadranglePointArray:pointArray];
    }
    else{
        [_rectView clearQuadranglePoint];
    }

}

#pragma mark ----- Action Method -----
- (IBAction)tapped:(id)sender{
    
}

#pragma mark ----- Private Method -----
- (void)setupAndStartAVCaptureSettion{

    [videoInput setup];
    [videoInput startCapture];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (trackingFlag){
        trackingFlag = NO;
    }
    else{
        trackingFlag = YES;
    }
    
    _rectView.trackingFlag = trackingFlag;
}
@end
