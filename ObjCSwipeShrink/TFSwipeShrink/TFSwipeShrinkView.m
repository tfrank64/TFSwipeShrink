//
//  TFSwipeShrinkView.m
//  TFSwipeShrink
//
//  Created by Taylor Franklin on 5/19/14.
//  Copyright (c) 2014 Taylor Franklin. All rights reserved.
//

#import "TFSwipeShrinkView.h"

@implementation TFSwipeShrinkView
{
    CGRect originalFrame;
    BOOL isLarge;
}

- (instancetype)initWithFrame:(CGRect)frame withTop:(UIView *)top andBottom:(UIView *)bottom
{
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;
    
    _topView = top;
    _bottomView = bottom;
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
    [self removeFromSuperview];
}

- (void)maximizeView:(UIPanGestureRecognizer *)recognizer
{
    if (isLarge) return;
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGAffineTransform first = CGAffineTransformMakeScale(2.0, 2.0);
        CGPoint destination = CGPointMake(-originalFrame.size.width * 4 / 9, -originalFrame.size.height * 10 / 9);
        CGAffineTransform second = CGAffineTransformTranslate(self.transform, destination.x, destination.y);
        
        CGAffineTransform combo = CGAffineTransformConcat(first, second);
        self.transform = combo;
        self.bottomView.hidden = NO;
        self.bottomView.alpha = 1;
    } completion:^(BOOL finished) {
        isLarge = YES;
    }];
    
    // TODO: possible implementation, need to modify to desired path or use some other sort of interactive transition
    
    /*CGPoint center = CGPointMake(63.0 + 194.0/2, 141.0+ 194.0/2);
    
    UIView *piece = [recognizer view];
    
    if ([recognizer state] == UIGestureRecognizerStateBegan || [recognizer state] == UIGestureRecognizerStateChanged)
    {
        if (piece == _topView)
        {
            
            CGPoint translation = [recognizer translationInView:[piece superview]];
            float newX = piece.frame.origin.x + translation.x;
            CGRect newFrame = piece.frame;
            
            CGPoint pinCenter = CGPointMake(newFrame.origin.x + newFrame.size.width / 2.0, newFrame.origin.y + newFrame.size.height / 2.0);
            newFrame.origin.x = newX;
            
            CGPoint newPinCenter = CGPointMake(newFrame.origin.x + newFrame.size.width / 2.0, newFrame.origin.y + newFrame.size.height / 2.0);
            
            float detectY = pinCenter.y + translation.y;
            BOOL bUpCenter = detectY < center.y;
            
            float deltaX = center.x - newPinCenter.x;
            float deltaY = sqrtf((97.0 *97.0) - (deltaX * deltaX));
            float newY;
            
            if (bUpCenter) {
                newY = center.y - deltaY;
            }
            else {
                newY = center.y + deltaY;
            }
            
            newY -= newFrame.size.height / 2.0;
            newFrame.origin.y = newY;
            
            if ((newPinCenter.x >= 63.0) && (newPinCenter.x <= 63.0+194.0))
            {
                [piece setFrame:newFrame];
            }
        }
        
        [recognizer setTranslation:CGPointZero inView:[piece superview]];
    }*/
}

- (void)minimizeView
{
    if (!isLarge) return;

    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        CGAffineTransform first = CGAffineTransformMakeScale(0.5, 0.5);
        CGPoint destination = CGPointMake(self.frame.size.width * 2 / 9, self.frame.size.height * 5 / 9);
        CGAffineTransform second = CGAffineTransformTranslate(self.transform, destination.x, destination.y);
        
        CGAffineTransform combo = CGAffineTransformConcat(first, second);
        self.transform = combo;
        self.bottomView.alpha = 0;
        
    } completion:^(BOOL finished) {
        self.bottomView.hidden = YES;
        isLarge = NO;
    }];
}

@end
