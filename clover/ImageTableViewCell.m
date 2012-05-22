//
//  ImageTableViewCell.m
//  clover
//
//  Created by 강동혁 on 12. 5. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setCellImage:(UIImage *)image
{
    cellImage = image;
}

- (void) drawRect:(CGRect)rect
{
    [cellImage drawAtPoint:rect.origin];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
