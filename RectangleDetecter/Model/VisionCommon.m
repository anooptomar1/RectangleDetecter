//
//  VisionCommon.m
//  RectangleDetecter
//
//  Created by yuki on 2017/10/31.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "VisionCommon.h"

@implementation VisionCommon

+ (NSMutableArray *)setQuadranglePointWithCGRect:(CGRect)rect frame:(CGRect)frame{
    
    NSMutableArray *pointArr = [NSMutableArray array];
    
    CGPoint setTopLeft      = CGPointMake(rect.origin.x * frame.size.width,
                                          rect.origin.y * frame.size.height);
    CGPoint setTopRight     = CGPointMake((rect.origin.x + rect.size.width) * frame.size.width,
                                           rect.origin.y * frame.size.height);
    CGPoint setBottomRight  = CGPointMake((rect.origin.x + rect.size.width)  * frame.size.width,
                                          (rect.origin.y + rect.size.height) * frame.size.height);
    CGPoint setBottomLeft   = CGPointMake(rect.origin.x * frame.size.width,
                                          (rect.origin.y + rect.size.height) * frame.size.height);
    
    [pointArr addObject:[NSValue valueWithCGPoint:setTopLeft]];
    [pointArr addObject:[NSValue valueWithCGPoint:setTopRight]];
    [pointArr addObject:[NSValue valueWithCGPoint:setBottomRight]];
    [pointArr addObject:[NSValue valueWithCGPoint:setBottomLeft]];
    
    return pointArr;
}

+ (NSMutableArray *)setQuadranglePointWithObservation:(VNRectangleObservation *)observation frame:(CGRect)frame{
    
    NSMutableArray *pointArr = [NSMutableArray array];
    
    CGPoint setTopLeft      = CGPointMake(observation.topLeft.x * frame.size.width,
                                          (1 - observation.topLeft.y) * frame.size.height);
    CGPoint setTopRight     = CGPointMake(observation.topRight.x *frame.size.width,
                                          (1 - observation.topRight.y) * frame.size.height);
    CGPoint setBottomRight  = CGPointMake(observation.bottomRight.x * frame.size.width,
                                          (1 - observation.bottomRight.y) * frame.size.height);
    CGPoint setBottomLeft   = CGPointMake(observation.bottomLeft.x * frame.size.width,
                                          (1 - observation.bottomLeft.y) * frame.size.height);
    
    [pointArr addObject:[NSValue valueWithCGPoint:setTopLeft]];
    [pointArr addObject:[NSValue valueWithCGPoint:setTopRight]];
    [pointArr addObject:[NSValue valueWithCGPoint:setBottomRight]];
    [pointArr addObject:[NSValue valueWithCGPoint:setBottomLeft]];
    
    return pointArr;
}

+ (CGImagePropertyOrientation)getCGImagePropertyOrientation:(UIImageOrientation)orientation{
    
    CGImagePropertyOrientation retOrientation = kCGImagePropertyOrientationUp;
    switch (orientation) {
        case UIImageOrientationUp:
            retOrientation = kCGImagePropertyOrientationUp;
            break;
        case UIImageOrientationUpMirrored:
            retOrientation = kCGImagePropertyOrientationUpMirrored;
            break;
        case UIImageOrientationDown:
            retOrientation = kCGImagePropertyOrientationDown;
            break;
        case UIImageOrientationDownMirrored:
            retOrientation = kCGImagePropertyOrientationDownMirrored;
            break;
        case UIImageOrientationLeft:
            retOrientation = kCGImagePropertyOrientationLeft;
            break;
        case UIImageOrientationLeftMirrored:
            retOrientation = kCGImagePropertyOrientationLeftMirrored;
            break;
        case UIImageOrientationRight:
            retOrientation = kCGImagePropertyOrientationRight;
            break;
        case UIImageOrientationRightMirrored:
            retOrientation = kCGImagePropertyOrientationRightMirrored;
            break;
        default:
            break;
    }
    
    return retOrientation;
}

@end
