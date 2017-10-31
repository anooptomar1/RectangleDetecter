//
//  TrackRectangle.m
//  RectangleDetecter
//
//  Created by yuki on 2017/10/31.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "TrackRectangle.h"

@interface TrackRectangle () {
    VNRectangleObservation  *rectangleObservation;
}

@end

@implementation TrackRectangle

- (id)init{
    
    self = [super init];
    if (self) {
        _sequenceHandler = [VNSequenceRequestHandler new];
        rectangleObservation = nil;
    }
    return self;
}

- (NSArray *)trackRectanglePointWithCIImage:(CIImage *)ciImage frame:(CGRect)frame{
    
    NSArray *pointArray = nil;
    
    VNTrackRectangleRequest *trackRequest = [[VNTrackRectangleRequest alloc] initWithRectangleObservation:rectangleObservation];
    trackRequest.trackingLevel = VNRequestTrackingLevelAccurate;
    
    NSArray *trackRequestArray = [NSArray arrayWithObject:trackRequest];
    
    [_sequenceHandler performRequests:trackRequestArray onCIImage:ciImage error:nil];
    if (trackRequest != nil && trackRequest.results != nil){
        NSMutableArray *rectArray = [NSMutableArray arrayWithArray:trackRequest.results];
        
        for (VNRectangleObservation *observation in rectArray){
            pointArray = [VisionCommon setQuadranglePointWithObservation:observation frame:frame];
            rectangleObservation = observation;
            break;
        }
    }
    return pointArray;
}

- (void)setObservation:(VNRectangleObservation *)observation{
    rectangleObservation = observation;
}

@end
