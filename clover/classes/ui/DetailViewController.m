//
//  DetailViewController.m
//  clover
//
//  Created by 강동혁 on 12. 5. 29..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 1.0f;
        _scrollView.minimumZoomScale = 0.4f;
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_scrollView addSubview:_imageView];
        [self.view addSubview:_scrollView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    
    UIImage *resizedImage;
    /*
    if(image.size.width > self.view.bounds.size.width) {
            
        float ratio = self.view.bounds.size.width/image.size.width;
        int resizeWidth = self.view.bounds.size.width;
        int resizeHeight = image.size.height * ratio;
        resizedImage = [self resizeImage:image newSize:CGSizeMake(resizeWidth/2, resizeHeight/2)];
    }
    else {
    */  
     resizedImage = image;
    //}
    
    [_imageView setImage:resizedImage];

    _imageView.frame = CGRectMake(0, 0, resizedImage.size.width, resizedImage.size.height);
    _imageView.center = CGPointMake(resizedImage.size.width/2, resizedImage.size.height/2);
    
    [_scrollView setContentSize:resizedImage.size];
    [_scrollView setZoomScale:_scrollView.minimumZoomScale];
}

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);  
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();    
    
    return newImage;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

@end
