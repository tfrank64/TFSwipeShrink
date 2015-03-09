//
//  TFSwipeShrinkView.h
//  TFSwipeShrink
//
//  Created by Taylor Franklin on 5/19/14.
//  Copyright (c) 2014 Taylor Franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFSwipeShrinkView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTop:(UIView *)top andBottom:(UIView *)bottom NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *bottomView;

@end
