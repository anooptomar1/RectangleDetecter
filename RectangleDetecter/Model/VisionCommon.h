//
//  VisionCommon.h
//  RectangleDetecter
//
//  Created by yuki on 2017/10/31.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Vision/Vision.h>

@interface VisionCommon : NSObject

+ (NSMutableArray *)setQuadranglePointWithCGRect:(CGRect)rect frame:(CGRect)frame;
+ (NSMutableArray *)setQuadranglePointWithObservation:(VNRectangleObservation *)observation frame:(CGRect)frame;
+ (CGImagePropertyOrientation)getCGImagePropertyOrientation:(UIImageOrientation)orientation;

@end
