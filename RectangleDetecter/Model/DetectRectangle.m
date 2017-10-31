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
    
    VNDetectRectanglesRequest *rectRequest = [VNDetectRectanglesRequest new];
    
    NSArray *requestArr = [NSArray arrayWithObject:rectRequest];
    [handler performRequests:requestArr error:nil];
    
    if (rectRequest != nil && rectRequest.results != nil){
        NSMutableArray *rectArr = [NSMutableArray arrayWithArray:rectRequest.results];
        if (rectArr != nil && [rectArr count] > 0){
            
            for (VNRectangleObservation *observation in rectArr){
                if (observation != nil){
                    pointArray = [VisionCommon setQuadranglePointWithObservation:observation frame:frame];
                    _observation = observation;
                    break;
                }
            }
        }
    }
    
    return pointArray;
}

@end

