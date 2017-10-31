//
//  DetectRectangle.h
//  RectangleDetecter
//
//  Created by yuki on 2017/10/31.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "VisionCommon.h"

@interface DetectRectangle : NSObject

@property (nonatomic, retain) VNRectangleObservation *observation;

- (NSArray *)detectRectanglePointWithCIImage:(CIImage *)ciImage frame:(CGRect)frame;

@end
