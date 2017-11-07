//
//  TrackRectangle.m
//  RectangleDetecter
//
//  Created by yuki on 2017/10/31.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "TrackRectangle.h"

@interface TrackRectangle ()
@end

@implementation TrackRectangle

- (id)init{
    
    self = [super init];
    if (self) {
        _sequenceHandler = [VNSequenceRequestHandler new];
        _observation = nil;
    }
    return self;
}

- (NSArray *)trackRectanglePointWithCIImage:(CIImage *)ciImage frame:(CGRect)frame{
    
    NSArray *pointArray = nil;
    
    VNTrackRectangleRequest *trackRequest = [[VNTrackRectangleRequest alloc] initWithRectangleObservation:_observation];
    trackRequest.trackingLevel = VNRequestTrackingLevelAccurate;
    
    NSArray *trackRequestArray = [NSArray arrayWithObject:trackRequest];
    
    [_sequenceHandler performRequests:trackRequestArray onCIImage:ciImage error:nil];
    if (trackRequest != nil && trackRequest.results != nil){
        NSMutableArray *rectArray = [NSMutableArray arrayWithArray:trackRequest.results];
        
        for (_observation in rectArray){
            pointArray = [VisionCommon setQuadranglePointWithObservation:_observation frame:frame];
            break;
        }
    }
    return pointArray;
}

@end
