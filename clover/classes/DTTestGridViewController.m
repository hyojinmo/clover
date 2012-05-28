//
//  DTTestGridViewController.m
//  clover
//
//  Created by 강동혁 on 12. 5. 28..
//  Copyright (c) 2012년 Rooftop. All rights reserved.
//

#import "DTTestGridViewCell.h"
#import "DTTestGridViewController.h"

@interface DTTestGridViewController ()

@end

@implementation DTTestGridViewController
@synthesize assetsLibrary;
@synthesize assetsList;

- (id)init {
	if (![super init])
		return nil;
	
    ALAssetsLibrary *newLibray = [[ALAssetsLibrary alloc] init];
    self.assetsLibrary = [newLibray retain];
    [newLibray release];
    
    self.assetsList = [[NSMutableArray alloc] initWithCapacity:0];
	
	return self;
}

- (void)dealloc {

	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Scroll" style:UIBarButtonItemStyleBordered target:self action:@selector(scroll)] autorelease];	
	self.title = @"DTGridView";
	self.gridView.delegate = self;
	self.gridView.dataSource = self;
	self.gridView.bounces = YES;
    
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return 50.0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return 25;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [NSString stringWithFormat:@"%i", row];
}

#pragma mark -
#pragma mark DTGridViewDataSource methods

- (NSInteger)numberOfRowsInGridView:(DTGridView *)gridView {
	return [self.assetsList count]/5 + 1;
}
- (NSInteger)numberOfColumnsInGridView:(DTGridView *)gridView forRowWithIndex:(NSInteger)index {
	return ([self.assetsList count] > 5)? 5 : [self.assetsList count];
}

- (CGFloat)gridView:(DTGridView *)gridView heightForRow:(NSInteger)rowIndex {
    
    return 100.0;
    
}
- (CGFloat)gridView:(DTGridView *)gridView widthForCellAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex {
	
    return 100.0;    
}

- (DTGridViewCell *)gridView:(DTGridView *)gv viewForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex {
	
	DTTestGridViewCell *cell = (DTTestGridViewCell *)[gv dequeueReusableCellWithIdentifier:@"cell"];
    
	if (!cell) {
		cell = [[[DTTestGridViewCell alloc] initWithReuseIdentifier:@"cell"] autorelease];
	}
    
    int idx = rowIndex * 10 + columnIndex;
    if(idx < [self.assetsList count]) {
        
        NSLog(@"index = %d", idx);
        
        ALAsset *asset = [self.assetsList objectAtIndex:idx];
        UIImage *image = [[UIImage alloc] initWithCGImage:asset.thumbnail];
        [cell.imageView setImage: image];
    }
    
	return cell;
}

#pragma mark -
#pragma mark DTGridViewDelegate methods

- (void)gridView:(DTGridView *)gv selectionMadeAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex {
	NSLog(@"%@:%@ %@", self, NSStringFromSelector(_cmd), [gv cellForRow:rowIndex column:columnIndex]);
	
}

- (void)gridView:(DTGridView *)gridView scrolledToEdge:(DTGridViewEdge)edge {
}

@end
