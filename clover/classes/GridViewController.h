//
//  GridViewController.h
//  clover
//
//  Created by Hyojin Mo on 12. 5. 24..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AQGridView.h"

@interface GridViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource> 
{
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *assetsList;
    AQGridView *gridview;
}

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) NSMutableArray *assetsList;

@property (nonatomic, retain) AQGridView *gridView;

@end
