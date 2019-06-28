//
//  BeautyLoadView.m
//  Beauty
//
//  Created by llk on 2018/8/20.
//  Copyright © 2018年 Beauty. All rights reserved.
//

#import "BeautyLoadView.h"
@interface BeautyLoadView()
@property(nonatomic,strong)UILabel * titleLabel;

@end
@implementation BeautyLoadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;

    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(self.bounds.size.width, self.bounds.size.height);
}

- (void)startAnimating {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.layer.hidden = NO;
    self.alpha = 1.0f;
    self.layer.speed = 1;
    [self setUpAnimation];
    [self addSubview:self.titleLabel];
     self.titleLabel.text = @"";
}
-(void)startAnimatingWithMessage:(NSString *)message {
    [self startAnimating];
    self.titleLabel.text = message;
}
-(void)startAnimatingWithProgress:(CGFloat)value message:(NSString *)message{
//    [[UIApplication sharedApplication].keyWindow addSubview:self];
//    self.layer.hidden = NO;
//    self.alpha = 1.0f;
//    [self addSubview:self.progressView];
//     self.progressView.reduceAngle = value;
//    self.progressView.progressLabel.text = message;
//    if (value == 1.0) {
//        [self.progressView removeFromSuperview];
//        self.alpha = 0;
//    }
    
}
- (void)stopAnimating {
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0;
                        
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
    
}

- (void)setUpAnimation {
    CGRect animationRect = UIEdgeInsetsInsetRect(self.frame, UIEdgeInsetsMake(0, 0, 0, 0));
    CGFloat minEdge = MIN(animationRect.size.width, animationRect.size.height);
    self.layer.sublayers = nil;
    CGSize size = CGSizeMake(kIphone6Width(40), kIphone6Width(40));
    [self setupAnimation:self.layer size:size color:kColor_Loding];
}
- (CALayer *)layerWithSize:(CGSize)size color:(UIColor *)color {
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path addArcWithCenter:CGPointMake(size.width / 2.0, size.height / 2.0 - 5) radius:(size.width / 2.0) startAngle:0 endAngle:(2 * M_PI) clockwise:NO];
    layer.fillColor = [color CGColor];
    layer.backgroundColor = nil;
    layer.path = [path CGPath];
    layer.frame = CGRectMake(0, 0, kIphone6Width(40), kIphone6Width(40));
    return layer;
}

- (void)setupAnimation:(CALayer *)layer size:(CGSize)size color:(UIColor *)color {
    CGFloat circleSize = size.width / 5.0;
    for (int i = 0; i < 5; i++) {
        CGFloat factor = i * 1.0 / 5.0;
        CALayer *circle = [self layerWithSize:CGSizeMake(circleSize, circleSize) color:color];
        
        CAAnimationGroup *animation = [self rotateAnimation:factor x:layer.bounds.size.width / 2.0 y:layer.bounds.size.height / 2.0 size:(CGSize){size.width - circleSize, size.height - circleSize}];
        circle.frame = CGRectMake(0, 0, circleSize, circleSize);
        [circle addAnimation:animation forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

- (CAAnimationGroup *)rotateAnimation:(CGFloat)rate
                                    x:(CGFloat)x
                                    y:(CGFloat)y
                                 size:(CGSize)size {
    CFTimeInterval duration = 1.5;
    CGFloat fromScale = 1 - rate;
    CGFloat toScale = 0.2 + rate;
    CAMediaTimingFunction *timeFunc = [CAMediaTimingFunction functionWithControlPoints:0.5 :0.15 + rate :0.25 :1.0];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = duration;
    scaleAnimation.repeatCount = HUGE;
    scaleAnimation.fromValue = @(fromScale);
    scaleAnimation.toValue = @(toScale);
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = duration;
    positionAnimation.repeatCount = HUGE;
    positionAnimation.path = [[UIBezierPath bezierPathWithArcCenter:(CGPoint){x, y} radius:size.width / 2.0 startAngle:3 * M_PI * 0.5 endAngle: 3 * M_PI * 0.5 + 2 * M_PI clockwise:YES] CGPath];
    
    CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
    animation.animations = @[scaleAnimation, positionAnimation];
    animation.timingFunction = timeFunc;
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = NO;
    
    return animation;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kIphone6Width(55), self.width, kIphone6Width(15))];
        _titleLabel.font = kFont12;
        _titleLabel.textColor = kColor_Loding;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

@end
