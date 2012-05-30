//
//  DetailViewController.h
//  clover
//
//  Created by 강동혁 on 12. 5. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController {
    
    UIScrollView *_scrollView;
    UIImageView *_imageView;
}

- (void) setImage : (UIImage *)image;

@end
