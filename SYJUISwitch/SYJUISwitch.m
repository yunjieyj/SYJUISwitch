//
//  SYJUISwitch.m
//  SYJUISwitch
//
//  Created by syj on 2021/8/17.
//

#import "SYJUISwitch.h"

@interface SYJUISwitch ()

@property (nonatomic, strong) UIView *bgColorView; //背景色
@property (nonatomic, strong) UIImageView *thumbImageView; //滑块

@property (nonatomic, assign) CGSize tempThumbSize;
@property (nonatomic, assign) BOOL tempIsOn;
@property (nonatomic, assign) NSInteger moveCount; //记录移动次数

@end

@implementation SYJUISwitch


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( (self = [super initWithCoder:aDecoder]) ){
        [self layoutIfNeeded];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = UIColor.clearColor;
    CGRect selfFrame = CGRectZero;
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        selfFrame = CGRectMake(0, 0, 51, 31);
    } else {
        selfFrame = self.frame;
    }
    self.frame = selfFrame;
    _onTintColor = [UIColor colorWithRed:103/255.0 green:204/255.0 blue:103/255.0 alpha:1];
    _offTintColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1];
    _thumbTintColor = UIColor.whiteColor;
    _thumbLeftSpace = 2;
    _thumbTopSpace = 2;
    _thumbSize = CGSizeMake(self.bounds.size.height - _thumbLeftSpace*2, self.bounds.size.height - _thumbTopSpace*2);
    _tailLength = 7;
    
    [self addSubview:self.bgColorView];
    [self addSubview:self.thumbImageView];
}

#pragma mark - Touch方法
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _moveCount = 0;
    _tempIsOn = self.isOn;
    _tempThumbSize = _thumbSize;
    _thumbSize.width = _thumbSize.width + _tailLength;
    [self updateThumbFrame:self.on animated:YES];
    [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView:self];
//    NSLog(@"x = %f",location.x);
    if (location.x <= 0) {
        if ([self currentPositionIsOn]) {
            [self updateThumbFrame:NO animated:YES];
            [self updateUI:NO animated:YES];
            _moveCount += 1;
        }
        
    } else if (location.x >= self.bounds.size.width) {
        if ([self currentPositionIsOn] == NO) {
            [self updateThumbFrame:YES animated:YES];
            [self updateUI:YES animated:YES];
            _moveCount += 1;
        }
    }
//    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [self endTracking];
}

- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    [self endTracking];
}

- (void)endTracking {
    _thumbSize = _tempThumbSize;
    BOOL isOn = !self.isOn;
    if (_moveCount >= 2) {
        isOn = [self currentPositionIsOn];
    }
    [self setOn:isOn animated:YES];
    if (_tempIsOn != self.isOn) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    _moveCount = 0;
}

- (BOOL)currentPositionIsOn {
    BOOL isOn = self.thumbImageView.center.x >= self.bounds.size.width/2.0;
    return isOn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgColorView.frame = self.bounds;
    self.bgColorView.layer.cornerRadius = self.bgColorView.frame.size.height/2.0;
    
    CGFloat x = self.on ? self.bounds.size.width - self.thumbSize.width - self.thumbLeftSpace : self.thumbLeftSpace;
    self.thumbImageView.frame = CGRectMake(x, self.thumbTopSpace, self.thumbSize.width, self.thumbSize.height);
    self.thumbImageView.layer.cornerRadius = self.thumbImageView.frame.size.height/2.0;
}

#pragma mark - Update
- (void)updateThumbFrame:(BOOL)on animated:(BOOL)animated {
    void (^taskBlock) (void) = ^{
        CGFloat x = on ? self.bounds.size.width - self.thumbSize.width - self.thumbLeftSpace : self.thumbLeftSpace;
        self.thumbImageView.frame = CGRectMake(x, self.thumbTopSpace, self.thumbSize.width, self.thumbSize.height);
        self.thumbImageView.layer.cornerRadius = self.thumbImageView.frame.size.height/2.0;
    };
    
    if (animated) {
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            taskBlock();
        } completion:^(BOOL finished) {
            
        }];
    } else {
        taskBlock();
    }
}

- (void)updateUI:(BOOL)on animated:(BOOL)animated {
    void (^taskBlock) (void) = ^{
        if (on) {
            self.bgColorView.backgroundColor = self.onTintColor;
            if (self.onImage) {
                self.thumbImageView.image = self.onImage;
            } else {
                self.thumbImageView.image = nil;
            }
        } else {
            self.bgColorView.backgroundColor = self.offTintColor;
            if (self.offImage) {
                self.thumbImageView.image = self.offImage;
            } else {
                self.thumbImageView.image = nil;
            }
        }
        self.thumbImageView.backgroundColor = self.thumbTintColor;
    };
    
    if (animated) {
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            taskBlock();
        } completion:^(BOOL finished) {
            
        }];
    } else {
        taskBlock();
    }
}

- (void)updateThumbPosition:(BOOL)on animated:(BOOL)animated {
    
    void (^taskBlock) (void) = ^{
//        CGFloat x = on ? self.bounds.size.width - self.thumbSize.width - self.thumbLeftSpace : self.thumbLeftSpace;
//        self.thumbImageView.frame = CGRectMake(x, self.thumbImageView.frame.origin.y, self.thumbSize.width, self.thumbSize.height);
        self.thumbImageView.bounds = CGRectMake(0, 0, self.thumbSize.width, self.thumbSize.height);
        CGPoint center = self.thumbImageView.center;
        if (on) {
            center.x = self.bounds.size.width - self.thumbImageView.frame.size.width/2.0 - self.thumbLeftSpace;
        } else {
            center.x = self.thumbImageView.frame.size.width/2.0 + self.thumbLeftSpace;
        }
        self.thumbImageView.center = center;
        
    };
   
    if (animated) {
        [UIView animateKeyframesWithDuration:0.2 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            taskBlock();
        } completion:^(BOOL finished) {
            
        }];
    } else {
        taskBlock();
    }
}

#pragma mark - Set
- (void)setOnTintColor:(UIColor *)onTintColor {
    _onTintColor = onTintColor;
    [self updateUI:self.on animated:YES];
}

- (void)setOffTintColor:(UIColor *)offTintColor {
    _offTintColor = offTintColor;
    [self updateUI:self.on animated:YES];
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    _thumbTintColor = thumbTintColor;
    [self updateUI:self.on animated:YES];
}

- (void)setOnImage:(UIImage *)onImage {
    _onImage = onImage;
    [self updateUI:self.on animated:YES];
}

- (void)setOffImage:(UIImage *)offImage {
    _offImage = offImage;
    [self updateUI:self.on animated:YES];
}

- (void)setThumbLeftSpace:(CGFloat)thumbLeftSpace {
    _thumbLeftSpace = thumbLeftSpace;
    [self updateThumbFrame:self.on animated:NO];
}

- (void)setThumbTopSpace:(CGFloat)thumbTopSpace {
    _thumbTopSpace = thumbTopSpace;
    [self updateThumbFrame:self.on animated:NO];
}

- (void)setThumbSize:(CGSize)thumbSize {
    _thumbSize = thumbSize;
    [self updateThumbFrame:self.on animated:NO];
}

- (void)setThumbLeftSpace:(CGFloat)thumbLeftSpace animated:(BOOL)animated {
    _thumbLeftSpace = thumbLeftSpace;
    [self updateThumbFrame:self.on animated:animated];
}
- (void)setThumbTopSpace:(CGFloat)thumbTopSpace animated:(BOOL)animated {
    _thumbTopSpace = thumbTopSpace;
    [self updateThumbFrame:self.on animated:animated];
}
- (void)setThumbSize:(CGSize)thumbSize animated:(BOOL)animated {
    _thumbSize = thumbSize;
    [self updateThumbFrame:self.on animated:animated];
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:NO];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    _on = on;
    [self updateThumbFrame:on animated:animated];
    [self updateUI:on animated:animated];
//    NSLog(@"%@", on ? @"开":@"关");
}

- (void)setEnabled:(BOOL)enabled {
    self.alpha = enabled ? 1.f : .5f;
    [super setEnabled:enabled];
}

/// 忽略返回手势，防止与侧滑手势冲突
- (BOOL)ignorePopGesture {
    return YES;
}

- (UIView *)bgColorView {
    if (!_bgColorView) {
        _bgColorView = [UIView new];
        _bgColorView.layer.masksToBounds = YES;
        _bgColorView.backgroundColor = self.offTintColor;
        _bgColorView.userInteractionEnabled = NO;
    }
    return _bgColorView;
}

- (UIImageView *)thumbImageView {
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.backgroundColor = self.thumbTintColor;
        _thumbImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _thumbImageView.layer.shadowOffset = CGSizeMake(0.0, 3.0);
        _thumbImageView.layer.shadowRadius = 3.0;
        _thumbImageView.layer.shadowOpacity = 0.3;
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.userInteractionEnabled = NO;
    }
    return _thumbImageView;
}


@end
