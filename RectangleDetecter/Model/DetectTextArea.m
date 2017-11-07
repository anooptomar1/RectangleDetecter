//
//  DetectTextArea.m
//  RectangleDetecter
//
//  Created by kubo on 2017/11/05.
//  Copyright © 2017年 kubo. All rights reserved.
//

#import "DetectTextArea.h"

@implementation DetectTextArea

- (id)init{
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSArray *)detectTextAreaWithCIImage:(CIImage *)ciImage frame:(CGRect)frame{
    
    NSMutableArray *textRectArray = [NSMutableArray arrayWithCapacity:1];
    
    CGImagePropertyOrientation orientation =
    [VisionCommon getCGImagePropertyOrientation:[UIImage imageWithCIImage:ciImage].imageOrientation];
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCIImage:ciImage orientation:orientation options:@{}];
    
    VNDetectTextRectanglesRequest *textRequest = [VNDetectTextRectanglesRequest new];
    textRequest.reportCharacterBoxes = YES;
    
    [handler performRequests:[NSArray arrayWithObject:textRequest] error:nil];
    
    for (VNTextObservation *textObservation in textRequest.results) {
        [textRectArray addObject:[VisionCommon setQuadranglePointWithCGRect:textObservation.boundingBox frame:frame]];
    }
    
    return textRectArray;
}

@end
