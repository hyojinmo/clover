//
//  ImagePropertiesLib.h
//  ImagePropertiesLib
//
//  Created by Hyojin Mo on 12. 5. 25..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <ImageIO/CGImageSource.h>
#import <ImageIO/CGImageProperties.h>
#import <ImageIO/CGImageDestination.h>

@interface ImagePropertiesLib : NSObject

+ (void) getImagePropertiesUsingBlockWithUrl:(NSURL *)url;
+ (void) getImagePropertiesUsingBlockWithAsset:(ALAsset *)asset;
+ (void) getImagePropertiesWithAsset:(ALAsset *)asset;
+ (void) saveImagePropertiesWithAsset:(ALAsset *)asset;

@end
