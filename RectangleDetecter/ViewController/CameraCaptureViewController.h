//
//  ViewController.h
//  RectangleDetecter
//
//  Created by yuki on 2017/10/29.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Vision/Vision.h>

#import "../Model/VideoInput.h"
#import "DrawRectView.h"

@interface CameraCaptureViewController : UIViewController <VideoInputDelegate>{
    
}

@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) DrawRectView* rectView;

- (IBAction)tapped:(id)sender;

@end

