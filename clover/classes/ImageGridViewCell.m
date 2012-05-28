//
//  ImageGridViewCell.m
//  clover
//
//  Created by 강동혁 on 12. 5. 28..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageGridViewCell.h"

@implementation ImageGridViewCell
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
