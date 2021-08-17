//
//  SYJUISwitch.h
//  SYJUISwitch
//
//  Created by syj on 2021/8/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYJUISwitch : UIControl

@property (nullable, nonatomic, strong) UIColor *onTintColor;
@property (nullable, nonatomic, strong) UIColor *offTintColor;
@property (nullable, nonatomic, strong) UIColor *thumbTintColor; //滑块颜色
@property (nullable, nonatomic, strong) UIImage *onImage; //滑块image
@property (nullable, nonatomic, strong) UIImage *offImage; //滑块image
@property (nonatomic, assign) CGFloat tailLength; //滑块拖尾长度，default = 7.0

@property (nonatomic, getter=isOn) BOOL on;  //default = NO
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@property (nonatomic, assign) CGFloat thumbLeftSpace; //滑块距离左边距离 default = 2.0
@property (nonatomic, assign) CGFloat thumbTopSpace; //滑块距离右边距离 default = 2.0
@property (nonatomic, assign) CGSize thumbSize; //滑块大小 default = (27, 27)
- (void)setThumbLeftSpace:(CGFloat)thumbLeftSpace animated:(BOOL)animated;
- (void)setThumbTopSpace:(CGFloat)thumbTopSpace animated:(BOOL)animated;
- (void)setThumbSize:(CGSize)thumbSize animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
