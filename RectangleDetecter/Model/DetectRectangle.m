//
//  DetectRectangle.m
//  RectangleDetecter
//
//  Created by yuki on 2017/10/31.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "DetectRectangle.h"

@implementation DetectRectangle

- (id)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSArray *)detectRectanglePointWithCIImage:(CIImage *)ciImage frame:(CGRect)frame{
    
    NSMutableArray *pointArray = nil;
    
    CGImagePropertyOrientation orientation =
                [VisionCommon getCGImagePropertyOrientation:[UIImage imageWithCIImage:ciImage].imageOrientation];
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCIImage:ciImage orientation:orientation options:@{}];
    
    VNDetectRectanglesRequest *rectanglesRequest = [VNDetectRectanglesRequest new];
    
    NSArray *requestArr = [NSArray arrayWithObject:rectanglesRequest];
    [handler performRequests:requestArr error:nil];
    
    for (_observation in rectanglesRequest.results){
        if (_observation != nil){
            pointArray = [VisionCommon setQuadranglePointWithObservation:_observation frame:frame];
            break;
        }
    }
    
    return pointArray;
}

@end

