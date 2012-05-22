//
//  ViewController.h
//  cloverTest2
//
//  Created by 강동혁 on 12. 5. 17..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define NOTIFICATION_ASSET_IMAGE_RETRIEVED @"ASSET_IMG_RETRIEVED"

@interface ViewController : UITableViewController {
    
@protected
    
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *assetsList;
}

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) NSMutableArray *assetsList;

@end
