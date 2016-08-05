//
//  AppElementConfig.h
//  MeiYuan
//
//  Created by kino on 16/3/31.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIColor (ConfigColor)

//浅色背景
+ (UIColor *)backgroundLightColor;

//cell分割线
+ (UIColor *)cellSpColoc;

+ (UIColor *)textColor;

@end


@interface UIButton (ConfigButton)

//- (void)applyButtonStyle;
+ (UIButton *)commonButtonWithTitle:(NSString *)title bgColor:(UIColor *)color;

- (void)applyAbleStyleWithTitle:(NSString *)title color:(UIColor *)color enable:(BOOL)enable;

@end



@interface UIFont (ConfigFont)

+ (UIFont *)applicationFontOfSize:(CGFloat)size;

@end



@interface UIView (ConfigView)

- (void)applyRoundStyle:(CGFloat)radius;
- (void)applyRoundBorderStyle:(CGFloat)radius;
- (void)applyRoundBorderStyle:(CGFloat)radius borderColor:(UIColor *)color;
- (void)applyRoundBorderStyle:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(float)width;


- (void)applyShadowWithCornerStyle:(CGFloat)radius;
- (void)applyShadowWithCornerStyle:(CGFloat)radius shadowRadius:(CGFloat)shadowRadius offset:(CGSize)offset;

- (void)applyCornerStyle:(CGFloat)radius corner:(UIRectCorner)corner;


- (UILabel *)configLabelWithFontSize:(CGFloat)size textColor:(UIColor *)color;

@end



@interface UIImage (configImage)

+ (UIImage *)placeHolderImage;
+ (UIImage *)placeHolderImageForAvatar;

- (UIImage *)createCornerImageBySize:(CGSize)size corner:(float)corner;


//截取部分图像
- (UIImage *)getSubImage:(CGRect)rect;

//等比例缩放
- (UIImage *)scaleToSize:(CGSize)size;


@end

@interface NSString (configString)

- (CGRect)frameWithWidth:(float)width fontSize:(float)fSize;
- (CGRect)frameWithWidth:(float)width fontSize:(float)fSize otherAttrDic:(NSDictionary *)dic;


- (BOOL)isPureNumandCharacters;
- (BOOL)isPureFloat;

- (NSAttributedString *)attrStringWithColor:(UIColor *)color forSubString:(NSString *)subStr;
- (NSAttributedString *)attrStringWithColor:(UIColor *)color forSubString:(NSString *)subStr lineHeight:(float)lh;

@end