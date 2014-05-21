//
//  SwipeShrinkView.m
//  SwipeShrink
//
//  Created by Taylor Franklin on 5/19/14.
//  Copyright (c) 2014 Taylor Franklin. All rights reserved.
//

#import "SwipeShrinkView.h"

@implementation SwipeShrinkView
{
    CGFloat scaleValue;
    CGRect originalFrame;
    BOOL isLarge;
}

- (id)initWithFrame:(CGRect)frame withTop:(UIView *)top andBottom:(UIView *)bottom
{
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;
    
    _topView = top;
    _bottomView = bottom;
    scaleValue = 1;
    originalFrame = self.frame;
    isLarge = YES;
    
    UIButton *lower = [UIButton buttonWithType:UIButtonTypeInfoLight];
    lower.frame = CGRectMake(10, 60, 50, 50);
    [lower addTarget:self action:@selector(removeMe) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:lower];
    
    [self addSubview:_topView];
    [self addSubview:_bottomView];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(minimizeView)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [top addGestureRecognizer:swipeGesture];
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(maximizeView:)];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    [top addGestureRecognizer:swipeUp];
    
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(maximizeView:)];
//    [top addGestureRecognizer:panGesture];
    
    return self;
}

- (void)removeMe
{
    NSLog(@"removing");
    [self removeFromSuperview];
}

- (void)maximizeView:(UIPanGestureRecognizer *)recognizer
{
    if (isLarge) return;
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGAffineTransform first = CGAffineTransformMakeScale(2.0, 2.0);
        CGPoint destination = CGPointMake(-originalFrame.size.width/2.25, -originalFrame.size.height-45);
        CGAffineTransform second = CGAffineTransformTranslate(self.transform, destination.x, destination.y);
        
        CGAffineTransform combo = CGAffineTransformConcat(first, second);
        self.transform = combo;
        self.bottomView.hidden = NO;
        self.bottomView.alpha = 1;
    } completion:^(BOOL finished) {
        isLarge = YES;
    }];
    /*CGPoint translation = [recognizer translationInView:self];
    if (translation.y >= 0)
    {
        NSLog(@"height: %f and new: %f", orginalHeight, recognizer.view.center.y + translation.y);
        scaleValue = (orginalHeight - (recognizer.view.center.y + translation.y))/448.0;
        NSLog(@"scale: %f", scaleValue);
        CGAffineTransform scale = CGAffineTransformMakeScale(scaleValue, scaleValue);
        self.transform = scale;
    }
    else
    {
        NSLog(@"height: %f and translation: %f final = %f", recognizer.view.center.y, translation.y, (orginalHeight - (recognizer.view.center.y + translation.y)));
        scaleValue = (orginalHeight - (recognizer.view.center.y + translation.y))/383.0;
        NSLog(@"scale: %f", scaleValue);
        CGAffineTransform scale = CGAffineTransformMakeScale(scaleValue, scaleValue);
        self.transform = scale;
    }
    
    recognizer.view.center = CGPointMake(self.bounds.size.width/2, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self];*/
}

- (void)minimizeView
{
    if (!isLarge) return;
    NSLog(@"shrinking...");
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGAffineTransform first = CGAffineTransformMakeScale(0.5, 0.5);
        CGPoint destination = CGPointMake(self.frame.size.width/4.5, self.frame.size.height/1.8);
        CGAffineTransform second = CGAffineTransformTranslate(self.transform, destination.x, destination.y);
        
        CGAffineTransform combo = CGAffineTransformConcat(first, second);
        self.transform = combo;
        self.bottomView.alpha = 0;
    } completion:^(BOOL finished) {
        self.bottomView.hidden = YES;
        isLarge = NO;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
