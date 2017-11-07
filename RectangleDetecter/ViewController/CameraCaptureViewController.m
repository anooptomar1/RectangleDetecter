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
#import "DetectTextArea.h"

@interface CameraCaptureViewController (){
    
    VNRectangleObservation      *lastObservation;

    
    CGRect                      *lastRect;
    BOOL                        trackingFlag;
    
    dispatch_queue_t            main_queue;
    dispatch_queue_t            other_queue;
    
    VideoInput                  *videoInput;
    DetectRectangle             *detectRectangle;
    TrackRectangle              *trackRectangle;
    DetectTextArea              *detectText;
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
    [self.view addSubview:_segControl];
    [self setupAndStartAVCaptureSettion];
    
    detectRectangle = [[DetectRectangle alloc] init];
    trackRectangle  = [[TrackRectangle alloc] init];
    detectText      =[[DetectTextArea alloc] init];
    
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
    
//    // 新しい画像サイズ
//    CGSize newSize = CGSizeMake(480, 640);
//    CGRect ciImageRect = captureCIImage.extent;
//    CGPoint scale = CGPointMake(newSize.width  / ciImageRect.size.width,
//                                newSize.height / ciImageRect.size.height);
//
//    CIImage *resizeCIImage = [captureCIImage imageByApplyingTransform:CGAffineTransformMakeScale(scale.x,scale.y)];
//
//    NSArray *pointArray = nil;
//
//    switch (_segControl.selectedSegmentIndex)
//    {
//        case kRectangleDetectMode:
//            pointArray = [detectRectangle detectRectanglePointWithCIImage:resizeCIImage frame:_imageView.frame];
//            [_rectView setQuadranglePointArray:pointArray];
//            break;
//        case kRectangleTrackingMode:
//        case kTextDetectMode:
//            trackRectangle.observation = detectRectangle.observation;
//            pointArray = [trackRectangle trackRectanglePointWithCIImage:resizeCIImage frame:_imageView.frame];
//            if (pointArray == nil){
//                pointArray = [detectRectangle detectRectanglePointWithCIImage:resizeCIImage frame:_imageView.frame];
//            }
//            [_rectView setQuadranglePointArray:pointArray];
//
//            if (_segControl.selectedSegmentIndex == kTextDetectMode && pointArray != nil){
//                CGFloat xPoint = fminf([[pointArray objectAtIndex:0] CGPointValue].x, [[pointArray objectAtIndex:3] CGPointValue].x);
//                CGFloat yPoint = fminf([[pointArray objectAtIndex:0] CGPointValue].y, [[pointArray objectAtIndex:1] CGPointValue].y);
//                CGFloat wPoint = fmaxf([[pointArray objectAtIndex:1] CGPointValue].x, [[pointArray objectAtIndex:2] CGPointValue].x) - xPoint;
//                CGFloat hPoint = fmaxf([[pointArray objectAtIndex:2] CGPointValue].y, [[pointArray objectAtIndex:3] CGPointValue].y) - yPoint;
//
//                CIImage *cropCIImage = [resizeCIImage imageByCroppingToRect:CGRectMake(xPoint, yPoint, wPoint, hPoint)];
//
//                pointArray = [detectText detectTextAreaWithCIImage:cropCIImage frame:_imageView.frame];
//                [_rectView setTextsPointArray:pointArray];
//            }
//            break;
//        default:
//            break;
//    }
}

#pragma mark ----- Action Method -----
- (IBAction)tapped:(id)sender{
    
}

- (IBAction)segChange:(id)sende{
    _rectView.appMode = _segControl.selectedSegmentIndex;
}

#pragma mark ----- Private Method -----
- (void)setupAndStartAVCaptureSettion{

    [videoInput setup];
    [videoInput startCapture];
}

@end
