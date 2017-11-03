//
//  VideoInput.h
//  RectangleDetecter
//
//  Created by yuki on 2017/10/29.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol VideoInputDelegate
- (void)getVideoCaptureCIImage:(CIImage *)captureCIImage;
@end


@interface VideoInput : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>{
    
    CIImage *captureCIImage;
}

@property (nonatomic, retain) AVCaptureSession* mySession;
@property (nonatomic, retain) id<VideoInputDelegate> videoInputDelegate;

- (void) setup;

- (void) startCapture;
- (void) stopCapture;
@end
