//
//  TrackRectangle.h
//  RectangleDetecter
//
//  Created by yuki on 2017/10/31.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "VisionCommon.h"

@interface TrackRectangle : NSObject

@property (nonatomic, assign) VNImageRequestHandler     *handler;
@property (nonatomic, retain) VNSequenceRequestHandler  *sequenceHandler;

- (NSArray *)trackRectanglePointWithCIImage:(CIImage *)ciImage frame:(CGRect)frame;
- (void)setObservation:(VNRectangleObservation *)observation;

@end
