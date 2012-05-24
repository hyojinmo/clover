//
//  GridViewController.m
//  clover
//
//  Created by Hyojin Mo on 12. 5. 24..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "GridViewController.h"
#import "GridViewCell.h"

@interface GridViewController ()

@end

@implementation GridViewController
@synthesize assetsLibrary;
@synthesize assetsList;
@synthesize gridView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"Grid View"];
        [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Grid View" image:nil tag:0]];
        
        ALAssetsLibrary *newLibray = [[ALAssetsLibrary alloc] init];
        assetsLibrary = [newLibray retain];
        [newLibray release];
        assetsList = [[NSMutableArray alloc] initWithCapacity:0];
        
        self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.gridView.autoresizesSubviews = YES;
        self.gridView.delegate = self;
        self.gridView.dataSource = self;
        [self.view addSubview:gridView];
        [self.gridView reloadData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
     
                                      usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                          
                                          if (group != nil) { 
                                              
                                              [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                  
                                                  if (result!=nil) { 
                                                      
                                                      [self.assetsList addObject:result];
                                                      [self.gridView reloadData];
                                                  } 
                                              }]; 
                                          }
                                          
                                      }
                                    failureBlock:^(NSError *error) { NSLog(@"failure: %@", [error description]) ; }]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc 
{
    [assetsLibrary release];
    [assetsList release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) aGridView
{
    return [self.assetsList count];
}

- (AQGridViewCell *) gridView: (AQGridView *) aGridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    
    GridViewCell * cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:@"PlainCellIdentifier"];
    
    if ( cell == nil )
    {
        cell = [[GridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 160, 123)
                                   reuseIdentifier: PlainCellIdentifier];
        
    }
    ALAsset *asset = [self.assetsList objectAtIndex:index];
    UIImage *image = [[UIImage alloc] initWithCGImage:asset.aspectRatioThumbnail];

    //UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://postfiles3.naver.net/20111128_130/kamiu09_1322445911366bK6ed_JPEG/%B0%AD%B9%CE%B0%E65.jpg?type=w2"]]];
    [cell.imageView setImage:image];
    [cell.captionLabel setText:@"A"];
    
    return cell;

}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(224.0, 168.0) );
}
@end
