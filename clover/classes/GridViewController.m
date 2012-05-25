//
//  GridViewController.m
//  clover
//
//  Created by Hyojin Mo on 12. 5. 24..
//  Copyright (c) 2012년 Rooftop. All rights reserved.
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
        self.assetsLibrary = [newLibray retain];
        [newLibray release];
        
        self.assetsList = [[NSMutableArray alloc] initWithCapacity:0];
        self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.gridView.autoresizesSubviews = YES;
        self.gridView.delegate = self;
        self.gridView.dataSource = self;
        [self.gridView resizesCellWidthToFit];
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
    UIImage *image = [[UIImage alloc] initWithCGImage:asset.aspectRatioThumbnail];
    UIImage *result = [self resizeImage:image newSize:CGSizeMake(image.size.width, image.size.height)];
    GridViewCell * cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:@"ImageCellIdentifier"];
    if ( cell == nil )
    {
        cell = [[GridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, image.size.width, image.size.height)
                                   reuseIdentifier: PlainCellIdentifier];
    }
    
    [cell.imageView setImage:result];
    
    return cell;

}

- (CGRect)gridView:(AQGridView *)gridView adjustCellFrame:(CGRect)cellFrame withinGridCellFrame:(CGRect)gridCellFrame {
    
    return CGRectMake(cellFrame.origin.x, cellFrame.origin.y, cellFrame.size.width, cellFrame.size.height);
}

- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index 
{
    // 이미지를 클릭하면 발생
    ALAsset *asset = [self.assetsList objectAtIndex:index];
    NSLog(@"%@", asset);
}

@end
