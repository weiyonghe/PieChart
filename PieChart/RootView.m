//
//  RootView.m
//  饼状图
//
//  Created by 魏永贺 on 16/4/5.
//  Copyright © 2016年 魏永贺. All rights reserved.
//

#import "RootView.h"
#import "RootModel.h"
@implementation RootView

@synthesize circlePath = _circlePath;
@synthesize bgCircleLayer = _bgCircleLayer;
@synthesize strokeWidth = _strokeWidth;

@synthesize percentLayer = _percentLayer;
@synthesize percentColor = _percentColor;
@synthesize perArray = _perArray;
@synthesize layerArray = _layerArray;

@synthesize isAnimation = _isAnimation;


-(id)initWithFrame:(CGRect)frame withStrokeWidth:(CGFloat )width andColor:(UIColor *)color andPerArray:(NSArray *)perArray andAnimation:(BOOL) animation
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _layerArray = [[NSMutableArray alloc]init];
        _strokeWidth = 60;
        
        _percentColor = color;
        _perArray = [NSArray arrayWithArray:perArray];
        _isAnimation = animation;
        
        
        CGPoint centerPoint = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2);
        CGFloat radius;
        if (self.bounds.size.width <= self.bounds.size.height) {
            radius = (self.bounds.size.width + 10)/2;
        }
        else
        {
            radius = (self.bounds.size.height +10)/2;
        }
        
        _circlePath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:M_PI_2*3 endAngle:-M_PI_2 clockwise:NO];
        
        [self buildBGCircleLayer];
    }
    return self;
}

-(void)buildBGCircleLayer
{
    _bgCircleLayer = [CAShapeLayer layer];
    _bgCircleLayer.path = _circlePath.CGPath;
    _bgCircleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    _bgCircleLayer.fillColor = [UIColor clearColor].CGColor;
    _bgCircleLayer.lineWidth = _strokeWidth;
    
    [self.layer addSublayer:_bgCircleLayer];
    
    
    [self addShowPercentLayer];
    
    
}
-(void)addShowPercentLayer
{
    CGFloat startPer = 0;
    for (RootModel *model in _perArray) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = _circlePath.CGPath;
        layer.strokeColor = [model color].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.lineWidth = _strokeWidth;
        layer.strokeStart = startPer;
        layer.strokeEnd = startPer +[model.perStr floatValue];
        [self.layer addSublayer:layer];
        [_layerArray addObject:layer];
        
        startPer += [model.perStr floatValue];
        //NSLog(@"the model per is %@",model.perStr);
        if (_isAnimation) {
            [self percentAnimationEveryLayer:layer];
        }
    }
    
}
-(void)percentAnimationEveryLayer:(CAShapeLayer *)layer
{
    CABasicAnimation *strokeEndAnimation = nil;
    strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = 0.0f;
    strokeEndAnimation.fromValue = @(layer.strokeStart);
    strokeEndAnimation.toValue = @(layer.strokeEnd);
    strokeEndAnimation.autoreverses = NO; //无自动动态倒退效果
    strokeEndAnimation.delegate = self;
    
    [layer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];
}

@end
