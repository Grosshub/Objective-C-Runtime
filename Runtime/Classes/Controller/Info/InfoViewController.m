//
//  InfoViewController.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "InfoViewController.h"
#import "MainViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)init {
    self = [super init];
    if (self) {
        
        _infoView = [[InfoView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)loadView {
    _infoView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = _infoView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.infoView.startButton addTarget:self action:@selector(startButtonTap:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Button events

- (void)startButtonTap:(UIButton *)sender {
    
    MainViewController * viewController = [[MainViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
