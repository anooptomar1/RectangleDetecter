//
//  DetectTextArea.h
//  RectangleDetecter
//
//  Created by kubo on 2017/11/05.
//  Copyright © 2017年 kubo. All rights reserved.
//

#import "VisionCommon.h"

@interface DetectTextArea : NSObject

- (NSArray *)detectTextAreaWithCIImage:(CIImage *)ciImage frame:(CGRect)frame;


@end
