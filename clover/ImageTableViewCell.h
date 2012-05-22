//
//  ImageTableViewCell.h
//  clover
//
//  Created by 강동혁 on 12. 5. 21..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell {
    
    UIImage *cellImage;
}

- (void) setCellImage:(UIImage*) image;

@end
