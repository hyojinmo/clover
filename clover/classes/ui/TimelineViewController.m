//
//  TimelineViewController.m
//  clover
//
//  Created by 강동혁 on 12. 5. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "TimelineViewController.h"
#import "PhotoListViewController.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

PhotoListViewController *_photoListViewController;

- (id)init
{
    self = [super init];
    if(self) {
        _photoListViewController = [[PhotoListViewController alloc] init];
        
        [self pushViewController:_photoListViewController animated:NO];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
