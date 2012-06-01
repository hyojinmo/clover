//
//  RootTabBarController.m
//  clover
//
//  Created by Hyojin Mo on 12. 5. 24..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "RootTabBarController.h"

#import "DTTestGridViewController.h"
#import "TimelineViewController.h"
#import "StoryViewController.h"
#import "PhotoListViewController.h"

@interface RootTabBarController ()

@end

//DTTestGridViewController *_testViewController;
TimelineViewController *_timelineViewController;
StoryViewController *_storyViewController;

@implementation RootTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //_testViewController = [[DTTestGridViewController alloc] init];
    
//    PhotoListViewController *photoListViewController = [[PhotoListViewController alloc] init];
    _timelineViewController = [[TimelineViewController alloc] init];
//    [photoListViewController release];
    
    _storyViewController = [[StoryViewController alloc] init];
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:_timelineViewController, _storyViewController, nil];
    
    [self setViewControllers:viewControllers];
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
