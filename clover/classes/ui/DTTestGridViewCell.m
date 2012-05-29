//
//  DTTestGridViewCell.m
//  clover
//
//  Created by 강동혁 on 12. 5. 28..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DTTestGridViewCell.h"

@implementation DTTestGridViewCell
@synthesize imageView;

- (id) initWithReuseIdentifier:(NSString *)anIdentifier
{
    self = [super initWithReuseIdentifier:anIdentifier];
    
    if(self == nil) {
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [self addSubview: self.imageView];
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
