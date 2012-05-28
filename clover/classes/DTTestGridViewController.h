//
//  DTTestGridViewController.h
//  clover
//
//  Created by 강동혁 on 12. 5. 28..
//  Copyright (c) 2012년 Rooftop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTGridViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface DTTestGridViewController : DTGridViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *assetsList;
    
}

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) NSMutableArray *assetsList;


@end
