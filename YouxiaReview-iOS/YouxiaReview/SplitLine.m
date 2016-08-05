//
//  SplitLine.m
//  MeiYuan
//
//  Created by kino on 16/4/18.
//
//

#import "SplitLine.h"

@implementation SplitLine{
    CGFloat _leftPos;
    CGFloat _rightPos;
    CALayer *_lineLayer;
}

- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame leftPosition:(CGFloat)left rightPosition:(CGFloat)right{
    if (self = [super initWithFrame:frame]) {
        _leftPos = left;
        _rightPos = right;
        [self initialize];
    }
    return self;
}

- (void)initialize{
    _lineLayer = [CALayer layer];
    _lineLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    
    [self.layer addSublayer:_lineLayer];
}

- (void)layoutSubviews{
    _lineLayer.frame = CGRectMake(_leftPos, 0, self.bounds.size.width - _leftPos - _rightPos, 1);
    
}

@end
