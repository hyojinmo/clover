//
//  PhotoListViewController.h
//  clover
//
//  Created by 강동혁 on 12. 5. 29..
//  Copyright (c) 2012년 Rooftop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AQGridView.h"
#import "DetailViewController.h"

#define VIEW_TITLE @"Photo"

@interface PhotoListViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource> {
    
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *assetsList;
    
    AQGridView *gridview;
    DetailViewController *detailViewController;
}

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) NSMutableArray *assetsList;
@property (nonatomic, retain) AQGridView *gridView;
@property (nonatomic, retain) DetailViewController *detailViewController;

@end
