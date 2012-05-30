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

@interface ImagePropertiesLib : NSObject

- (void) getImagePropertiesWithAsset: (ALAsset *) asset;
- (void) getImagePropertiesWithUrl:(NSURL *)url;

@end
