//
//  ViewController.m
//  cloverTest2
//
//  Created by 강동혁 on 12. 5. 17..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize assetsLibrary;
@synthesize assetsList;

- (id) init {
    
    if(self != nil) {
        
        ALAssetsLibrary *newLibray = [[ALAssetsLibrary alloc] init];
        assetsLibrary = [newLibray retain];
        [newLibray release];
        
        assetsList = [[NSMutableArray alloc] initWithCapacity:0];
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.tableView.allowsSelection = NO;
        self.tableView.rowHeight = self.view.bounds.size.height;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
     
        usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                
            if (group != nil) { 
                
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                    if (result!=nil) { 
                        
                        [self.assetsList addObject:result];
                    } 
                }]; 
            }
            
            [self.tableView reloadData];
        }
       failureBlock:^(NSError *error) { NSLog(@"failure: %@", [error description]) ; }]; 
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
  
}

- (void)dealloc {
    
    [assetsLibrary release];
    [assetsList release];
    [super dealloc];
}

#pragma mark UITableViewController delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [self.assetsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.opaque = YES;
        
    }
    
    ALAsset *asset = [self.assetsList objectAtIndex:indexPath.row];
    UIImage *image = [[UIImage alloc] initWithCGImage:asset.aspectRatioThumbnail];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [cell.contentView addSubview:imageView];
    //NSLog(@"width = %@ , height = %@", image.size.width, image.size.height);
    
    
    //NSLog(@"%@", asset.defaultRepresentation.fullScreenImage);
    //cell.frame = self.view.bounds;
    //cell.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //UIImage *image = [UIImage imageWithCGImage:[asset thumbnail]];
    /*
    float resizeWidth = 300;
    float resizeHeight = 300;
    
    UIGraphicsBeginImageContext(CGSizeMake(resizeWidth, resizeHeight));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, resizeHeight);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0, 0.0, resizeWidth, resizeHeight), [image CGImage]);
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    */
    
    
    //UIImage *image = [[UIImage alloc] initWithCGImage:asset.defaultRepresentation.fullResolutionImage];
    //UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //[imageView setContentMode:UIViewContentModeScaleAspectFit];
    //[imageView setImage:image];
    //[cell.contentView addSubview:imageView];
    
    return cell;
}

@end
