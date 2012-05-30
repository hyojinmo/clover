//
//  DetailViewController.m
//  clover
//
//  Created by 강동혁 on 12. 5. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        [self.view addSubview:self.imageView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.imageView.center = CGPointMake(self.view.bounds.size.width/2, image.size.height/2);
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
