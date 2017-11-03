//
//  VideoInput.m
//  RectangleDetecter
//
//  Created by yuki on 2017/10/29.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "VideoInput.h"

@interface VideoInput ()

- (BOOL)convertSampleBufferToImage:(CMSampleBufferRef)sampleBuffer;
@end

@implementation VideoInput{
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setup{
    
    //入力作成
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //ビデオデータ出力作成
    NSDictionary* settings = @{(id)kCVPixelBufferPixelFormatTypeKey:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]};
    AVCaptureVideoDataOutput *outputData = [[AVCaptureVideoDataOutput alloc] init];
    outputData.videoSettings = settings;
    [outputData setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    //セッション作成
    _mySession = [[AVCaptureSession alloc] init];
    [_mySession addInput:inputDevice];
    [_mySession addOutput:outputData];
    _mySession.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    AVCaptureConnection *videoConnection = nil;
    
    // カメラの向きなどを設定
    [_mySession beginConfiguration];
    
    for (AVCaptureConnection *connection in [outputData connections]){
        for (AVCaptureInputPort *port in [connection inputPorts]){
            if ([[port mediaType] isEqual:AVMediaTypeVideo]){
                videoConnection = connection;
                break;
            }
        }
    }
    
    if ([videoConnection isVideoOrientationSupported]){
        [videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    [_mySession commitConfiguration];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    if ([self convertSampleBufferToImage:sampleBuffer]){
        [_videoInputDelegate getVideoCaptureCIImage:captureCIImage];
    }
    
}

- (BOOL)convertSampleBufferToImage:(CMSampleBufferRef)sampleBuffer{
    
    BOOL ret = YES;
    
    // CMSampleBufferRef -> CVPixelBufferRef
    CVPixelBufferRef pixcelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // CVPixelBufferRef -> CIImage
    captureCIImage = [CIImage imageWithCVPixelBuffer:pixcelBuffer];
    if (captureCIImage == nil){
        ret = NO;
    }
    
    return ret;
}

- (void)startCapture{
    [_mySession startRunning];
}

- (void)stopCapture{
 
    [_mySession stopRunning];
}

@end
