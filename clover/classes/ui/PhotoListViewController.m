//
//  PhotoListViewController.m
//  clover
//
//  Created by 강동혁 on 12. 5. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "PhotoListViewController.h"
#import "ImageGridViewCell.h"
#import "DetailViewController.h"

@interface PhotoListViewController ()

@end

@implementation PhotoListViewController
@synthesize assetsLibrary;
@synthesize assetsList;
@synthesize gridView;
@synthesize detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setTitle:VIEW_TITLE];
        self.detailViewController = [[DetailViewController alloc] init];
        
        
        [self initAssetLib];
        [self initGridView];
    }
    return self;
}

- (void) initAssetLib 
{
    ALAssetsLibrary *newLibray = [[ALAssetsLibrary alloc] init];
    self.assetsLibrary = [newLibray retain];
    [newLibray release];
}

- (void) initGridView
{
     self.assetsList = [[NSMutableArray alloc] initWithCapacity:0];
     self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
     self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
     self.gridView.autoresizesSubviews = YES;
     self.gridView.delegate = self;
     self.gridView.dataSource = self;
     self.gridView.backgroundColor = [UIColor whiteColor];
    
     [self.view addSubview:gridView];
     [self.gridView reloadData];
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
}

- (void)dealloc 
{
    [gridview release];
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
    static NSString * PlainCellIdentifier = @"ImageCellIdentifier";
    
    ALAsset *asset = [self.assetsList objectAtIndex:index];
    UIImage *image = [[UIImage alloc] initWithCGImage:asset.thumbnail];
    ImageGridViewCell * cell = (ImageGridViewCell *)[aGridView dequeueReusableCellWithIdentifier:@"ImageCellIdentifier"];
    if ( cell == nil )
    {
        cell = [[ImageGridViewCell alloc] initWithFrame:CGRectMake(0, 0, 75, 75) reuseIdentifier:PlainCellIdentifier];
    }
    
    [cell.imageView setImage:image];
    
    return cell;
}

/*
 - (CGRect)gridView:(AQGridView *)gridView adjustCellFrame:(CGRect)cellFrame withinGridCellFrame:(CGRect)gridCellFrame {
 
 return CGRectMake(cellFrame.origin.x, cellFrame.origin.y, 60, 60);
 }
 */

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)gridView 
{
    return CGSizeMake(80, 80);
}

- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index 
{
    // 이미지를 클릭하면 발생
    ALAsset *asset = [self.assetsList objectAtIndex:index];
    UIImage *image = [[UIImage alloc] initWithCGImage:asset.defaultRepresentation.fullScreenImage];
    
    [detailViewController setImage:image];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}


@end
