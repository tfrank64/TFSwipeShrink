//
//  ViewController.m
//  SwipeShrink
//
//  Created by Taylor Franklin on 5/19/14.
//  Copyright (c) 2014 Taylor Franklin. All rights reserved.
//

#import "ViewController.h"
#import "SwipeShrinkView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) SwipeShrinkView *overView;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIView *extraInfoView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mainTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:_mainTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"CellIdentifier";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = @"?";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_mainTableView deselectRowAtIndexPath:indexPath animated:YES];
    CGRect theFrame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    
    _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, theFrame.size.width, theFrame.size.height/3)];
    _infoView.backgroundColor = [UIColor purpleColor];
    _extraInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, theFrame.size.height/3, theFrame.size.width, theFrame.size.height/3 * 2)];
    _extraInfoView.backgroundColor = [UIColor colorWithRed:1.000 green:0.240 blue:0.179 alpha:1.000];
    
    if (_overView != nil)
        [_overView removeFromSuperview];
    
    _overView = [[SwipeShrinkView alloc] initWithFrame:theFrame withTop:_infoView andBottom:_extraInfoView];
    [self.view addSubview:_overView];
}

@end