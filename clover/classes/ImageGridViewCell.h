//
//  ImageGridViewCell.h
//  clover
//
//  Created by 강동혁 on 12. 5. 28..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridViewCell.h"

@interface ImageGridViewCell : AQGridViewCell {

    UIImageView *imageView;
}

@property (nonatomic, retain) UIImageView *imageView;

@end
