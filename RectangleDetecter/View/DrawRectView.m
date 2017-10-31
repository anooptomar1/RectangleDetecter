//
//  DrawRectView.m
//  RectangleDetecter
//
//  Created by yuki on 2017/10/29.
//  Copyright © 2017年 yuki. All rights reserved.
//

#import "DrawRectView.h"

@interface DrawRectView(){
    NSMutableArray *pointArr;
}

@end

@implementation DrawRectView

- (id)init
{
    self = [super init];
    if (self) {
        _trackingFlag = NO;
        pointArr = [NSMutableArray arrayWithCapacity:4];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _trackingFlag = NO;
        pointArr = [[NSMutableArray alloc] initWithCapacity:4];
        self.opaque = NO;
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    }
    return self;
}

- (void)setQuadranglePointArray:(NSArray *)array{
    
    if ([array count] == 4){
        [pointArr removeAllObjects];
        for(NSNumber *point in array){
            [pointArr addObject:point];
        }
        [self setNeedsDisplay];
    }
}

- (void)clearQuadranglePoint{
    [pointArr removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    
    if (_trackingFlag == NO){
        [[UIColor blueColor] setStroke];
    }
    else{
        [[UIColor greenColor] setStroke];
    }
    
    bPath.lineWidth = 5;
    
    if (pointArr != nil && [pointArr count] == 4){
        [bPath moveToPoint:[[pointArr objectAtIndex:0] CGPointValue]];
        [bPath addLineToPoint:[[pointArr objectAtIndex:1] CGPointValue]];
        [bPath addLineToPoint:[[pointArr objectAtIndex:2] CGPointValue]];
        [bPath addLineToPoint:[[pointArr objectAtIndex:3] CGPointValue]];
        [bPath addLineToPoint:[[pointArr objectAtIndex:0] CGPointValue]];

        [bPath stroke];
    }
}

@end
