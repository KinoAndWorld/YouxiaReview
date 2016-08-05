//
//  AppElementConfig.m
//  MeiYuan
//
//  Created by kino on 16/3/31.
//
//

#import "AppElementConfig.h"

#import <objc/runtime.h>

#import <UIColor+BFKit.h>

@implementation UIColor (ConfigColor)

+ (UIColor *)backgroundLightColor{
    return [UIColor colorWithWhite:0.95 alpha:1.0];
}

//cell分割线
+ (UIColor *)cellSpColoc{
    return [UIColor colorWithWhite:0.9 alpha:1.000];
}

+ (UIColor *)textColor{
    return [UIColor colorWithHex:0x525252];
}

@end


@implementation UIButton (ConfigButton)

+ (void)load{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode{
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.titleLabel.font.pointSize;
        self.titleLabel.font = [UIFont applicationFontOfSize:fontSize];
    }
    return self;
}

+ (UIButton *)commonButtonWithTitle:(NSString *)title bgColor:(UIColor *)color{
    UIButton *commonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commonButton setBackgroundColor:color];
    [commonButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commonButton setTitle:title forState:UIControlStateNormal];
    commonButton.titleLabel.font = [UIFont applicationFontOfSize:15.f];
    
    return commonButton;
}

- (void)applyAbleStyleWithTitle:(NSString *)title color:(UIColor *)color enable:(BOOL)enable{
    //    [self setBackgroundImage:[UIImage imageNamed:@"mainOKButton"] forState:UIControlStateNormal];
    [self setBackgroundColor:color];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateNormal];
    self.userInteractionEnabled = enable;
}

@end


@implementation UIFont (ConfigFont)

+ (UIFont *)applicationFontOfSize:(CGFloat)size{
    return [UIFont systemFontOfSize:size];//[UIFont fontWithName:@"SourceHanSansCN-ExtraLight" size:size];
}

@end


@implementation UIView (ConfigView)

- (void)applyRoundStyle:(CGFloat)radius{
    self.layer.cornerRadius = radius;
}

- (void)applyRoundBorderStyle:(CGFloat)radius{
    [self applyRoundBorderStyle:radius borderColor:[UIColor clearColor]];
}

- (void)applyRoundBorderStyle:(CGFloat)radius borderColor:(UIColor *)color{
    return [self applyRoundBorderStyle:radius borderColor:color borderWidth:1];
}

- (void)applyRoundBorderStyle:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(float)width{
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}


/**
 *  new effect
 */
- (void)applyShadowWithCornerStyle:(CGFloat)radius shadowRadius:(CGFloat)shadowRadius offset:(CGSize)offset{
    self.layer.masksToBounds = NO;
//    self.layer.cornerRadius = radius;
    self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = offset;//默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
}

- (void)applyShadowWithCornerStyle:(CGFloat)radius{
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = radius;
    self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0,0);//默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.layer.shadowRadius = 2;//阴影半径，默认3
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
}

- (void)applyCornerStyle:(CGFloat)radius corner:(UIRectCorner)corner{
    
    if (!CGRectEqualToRect(CGRectZero, self.bounds)) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                       byRoundingCorners:corner
                                                             cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (UILabel *)configLabelWithFontSize:(CGFloat)size textColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont applicationFontOfSize:size];
    label.textColor = color;
    label.text = @"10086";
    
    return label;
}

@end


@implementation UIImage (configImage)

+ (UIImage *)placeHolderImage{
    return [UIImage imageNamed:@"placeHolder"];
}

+ (UIImage *)placeHolderImageForAvatar{
    return [UIImage imageNamed:@"tabPeople"];
}

- (UIImage *)createCornerImageBySize:(CGSize)size corner:(float)corner{
    
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen mainScreen].scale);
    
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)].CGPath);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return output;
}

//截取部分图像
- (UIImage *)getSubImage:(CGRect)rect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//等比例缩放
- (UIImage *)scaleToSize:(CGSize)size{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}


@end


@implementation NSString (configString)

- (CGRect)frameWithWidth:(float)width fontSize:(float)fSize{
    
    if ([self isEqualToString:@""]) {
        return CGRectZero;
    }
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    CGRect resultFrame = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont applicationFontOfSize:fSize]} context:nil];
    
    NSLog(@"%@ height is %f", self, resultFrame.size.height);
    
    return resultFrame;
}

- (CGRect)frameWithWidth:(float)width fontSize:(float)fSize otherAttrDic:(NSDictionary *)dic{
    if ([self isEqualToString:@""]) {
        return CGRectZero;
    }
    
    NSMutableDictionary *attrDic = [NSMutableDictionary dictionaryWithDictionary:@{NSFontAttributeName: [UIFont applicationFontOfSize:fSize]}];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![key isEqualToString:NSFontAttributeName]) {
            [attrDic setObject:obj forKey:key];
        }
    }];
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    CGRect resultFrame = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDic context:nil];
    
    NSLog(@"%@ height is %f", self, resultFrame.size.height);
    
    return resultFrame;
    
}

- (BOOL)isPureNumandCharacters{
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(result.length > 0){
        return NO;
    }
    return YES;
}

- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

- (NSAttributedString *)attrStringWithColor:(UIColor *)color forSubString:(NSString *)subStr{
    NSRange subStrRange = [self rangeOfString:subStr];
    if (subStrRange.length > 0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:subStrRange];
        
        return attrStr;
    }
    
    return [[NSAttributedString alloc] initWithString:self];
}

- (NSAttributedString *)attrStringWithColor:(UIColor *)color forSubString:(NSString *)subStr lineHeight:(float)lh{
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (color && subStr) {
        NSRange subStrRange = [self rangeOfString:subStr];
        if (subStrRange.length > 0) {
            [attrStr addAttribute:NSForegroundColorAttributeName value:color range:subStrRange];
            return attrStr;
        }
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lh];
    [attrStr addAttribute:NSParagraphStyleAttributeName
                    value:style
                    range:NSMakeRange(0, self.length)];
    
    
    return attrStr;
}

@end