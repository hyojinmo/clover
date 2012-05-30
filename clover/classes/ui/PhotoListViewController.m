//
//  PhotoListViewController.m
//  clover
//
//  Created by 강동혁 on 12. 5. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "PhotoListViewController.h"
#import "ImageGridViewCell.h"
#import "ImagePropertiesLib.h"

@interface PhotoListViewController ()

@end

@implementation PhotoListViewController
@synthesize assetsLibrary;
@synthesize assetsList;
@synthesize gridView;

ImagePropertiesLib *_imagePropertiesLib;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setTitle:VIEW_TITLE];
        [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:VIEW_TITLE image:nil tag:0]];
        
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
    
    _imagePropertiesLib = [[ImagePropertiesLib alloc] init];
}

- (void) initGridView
{
     self.assetsList = [[NSMutableArray alloc] initWithCapacity:0];
     self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
     self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
     self.gridView.autoresizesSubviews = YES;
     self.gridView.delegate = self;
     self.gridView.dataSource = self;
    
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
    // Release any retained subviews of the main view.
}

- (void)dealloc 
{
    [gridview release];
    [assetsLibrary release];
    [assetsList release];
    [super dealloc];
}

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);  
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();    
    
    return newImage;
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
    [_imagePropertiesLib getImagePropertiesWithAsset:asset];
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
    //ALAsset *asset = [self.assetsList objectAtIndex:index];
    Class class = NSClassFromString(@"DetailViewController");
    id detailViewController = [[[class alloc] init] autorelease];
    
    if(detailViewController) {
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}


@end
