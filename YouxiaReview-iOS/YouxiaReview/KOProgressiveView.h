//
//  KOProgressiveView.h
//  MeiYuan
//
//  Created by kino on 16/4/20.
//
//

#import <UIKit/UIKit.h>

#import <YYWebImage.h>

@interface KOProgressiveView : UIView

@property (nonatomic, strong) YYAnimatedImageView *imageView;
@property (nonatomic, strong) CAShapeLayer *progressLayer;


- (void)setImageURL:(NSURL *)url;

- (void)setImageURL:(NSURL *)url placeholder:(UIImage *)image;


@end
