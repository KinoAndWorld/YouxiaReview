//
//  KOProgressiveView.m
//  MeiYuan
//
//  Created by kino on 16/4/20.
//
//

#import "KOProgressiveView.h"

#import <Masonry.h>

#define useWeakSelf __weak typeof(self) weakSelf = self;

@implementation KOProgressiveView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    
    return self;
}

- (void)awakeFromNib{
    [self initialize];
}


- (void)initialize{
    _imageView = [[YYAnimatedImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_imageView];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.strokeColor = [UIColor colorWithRed:0.000 green:0.640 blue:1.000 alpha:0.720].CGColor;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd = 0;
    [_imageView.layer addSublayer:_progressLayer];
}

- (void)layoutSubviews{
    CGFloat lineHeight = 4;
    
    _progressLayer.frame = CGRectMake(0, 0, self.frame.size.width, lineHeight);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height - _progressLayer.frame.size.height / 2)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - _progressLayer.frame.size.height / 2)];
    _progressLayer.lineWidth = lineHeight;
    _progressLayer.path = path.CGPath;
    
}

- (void)setImageURL:(NSURL *)url{
    return [self setImageURL:url placeholder:nil];
}

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)image{
    useWeakSelf
    
    [CATransaction begin];
    [CATransaction setDisableActions: YES];
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
    [CATransaction commit];
    
    //just one time enough
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:[YYWebImageManager sharedManager].headers];
        headers[@"Referer"] = @"http://spotlight.pics";
        [YYWebImageManager sharedManager].headers = headers;
    });
    
    [_imageView yy_setImageWithURL:url
                            placeholder:image
                                options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity | YYWebImageOptionSetImageWithFadeAnimation
                               progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                   if (expectedSize > 0 && receivedSize > 0) {
                                       CGFloat progress = (CGFloat)receivedSize / expectedSize;
                                       progress = progress < 0 ? 0 : progress > 1 ? 1 : progress;
                                       if (weakSelf.progressLayer.hidden) weakSelf.progressLayer.hidden = NO;
                                       weakSelf.progressLayer.strokeEnd = progress;
                                   }
                               }
                              transform:nil/*^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
                                  UIImage *resImage = [image getSubImage:self.imageView.bounds];
                                  return resImage;
                              }*/completion:^(UIImage *image, NSURL *url, YYWebImageFromType from, YYWebImageStage stage, NSError *error) {
                                 if (stage == YYWebImageStageFinished) {
                                     weakSelf.progressLayer.hidden = YES;
                                 }
                             }];
    
}

@end
