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
    NSMutableArray *textRectArr;
}

@end

@implementation DrawRectView

- (id)init
{
    self = [super init];
    if (self) {
        _appMode = kRectangleDetectMode;
        pointArr = [[NSMutableArray alloc] initWithCapacity:1];
        textRectArr = [[NSMutableArray alloc] initWithCapacity:1];
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _appMode = kRectangleDetectMode;
        pointArr = [[NSMutableArray alloc] initWithCapacity:1];
        textRectArr = [[NSMutableArray alloc] initWithCapacity:1];

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

- (void)setTextsPointArray:(NSArray *)array{
    
    [textRectArr removeAllObjects];
    for (NSMutableArray *array1 in array){
        if ([array1 count] == 4){
            NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:1];
            for(NSNumber *point in array1){
                [array2 addObject:point];
            }
            [textRectArr addObject:array2];
        }
    }
    [self setNeedsDisplay];
}

- (void)clearQuadranglePoint{
    [pointArr removeAllObjects];
    [textRectArr removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    UIBezierPath *testPath =  [UIBezierPath bezierPath];
    
    switch (_appMode) {
        case kRectangleDetectMode:
            [[UIColor blueColor] setStroke];
            break;
        case kRectangleTrackingMode:
        case kTextDetectMode:
            [[UIColor greenColor] setStroke];
            break;
        default:
            break;
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
    
    if (_appMode == kTextDetectMode){
        testPath.lineWidth = 4;

        [[UIColor redColor] setStroke];
        for (NSArray *showArr in textRectArr){
            if (showArr != nil && [showArr count] == 4){
                [testPath moveToPoint:[[showArr objectAtIndex:0] CGPointValue]];
                [testPath addLineToPoint:[[showArr objectAtIndex:1] CGPointValue]];
                [testPath addLineToPoint:[[showArr objectAtIndex:2] CGPointValue]];
                [testPath addLineToPoint:[[showArr objectAtIndex:3] CGPointValue]];
                [testPath addLineToPoint:[[showArr objectAtIndex:0] CGPointValue]];
                
                [testPath stroke];
            }
        }
    }
}

@end
