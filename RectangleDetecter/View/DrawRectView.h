//
//  DrawRectView.h
//  RectangleDetecter
//
//  Created by yuki on 2017/10/29.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawRectView : UIView

@property (nonatomic, assign) BOOL trackingFlag;
- (void)setQuadranglePointArray:(NSArray *)array;
- (void)clearQuadranglePoint;

@end
