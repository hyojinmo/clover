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
    // 이 asset을 이용해서 앨범에 있는 사진이 접근 할 수 있음
    
    
    return cell;
}

@end
