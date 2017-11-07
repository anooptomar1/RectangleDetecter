//
//  DrawRectView.h
//  RectangleDetecter
//
//  Created by yuki on 2017/10/29.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kAppMode) {
    kRectangleDetectMode,
    kRectangleTrackingMode,
    kTextDetectMode
};

@interface DrawRectView : UIView

@property (nonatomic, assign) kAppMode appMode;

- (void)setQuadranglePointArray:(NSArray *)array;
- (void)setTextsPointArray:(NSArray *)array;
- (void)clearQuadranglePoint;

@end
