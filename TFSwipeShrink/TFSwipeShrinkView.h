//
//  TFSwipeShrinkView.h
//  TFSwipeShrink
//
//  Created by Taylor Franklin on 5/19/14.
//  Copyright (c) 2014 Taylor Franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFSwipeShrinkView : UIView

- (id)initWithFrame:(CGRect)frame withTop:(UIView *)top andBottom:(UIView *)bottom;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;

@end
