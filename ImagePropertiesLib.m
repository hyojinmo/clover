//
//  ImagePropertiesLib.m
//  ImagePropertiesLib
//
//  Created by Hyojin Mo on 12. 5. 25..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ImagePropertiesLib.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import <ImageIO/CGImageSource.h>
#import <ImageIO/CGImageProperties.h>

@implementation ImagePropertiesLib

- (void) getImagePropertiesDictionaryWithUrl:(NSURL *)url {
    double timestamp = [[NSDate date] timeIntervalSince1970];
    
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:0];
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
        ALAssetRepresentation *image_representation = [asset defaultRepresentation];
        
        // create a buffer to hold image data 
        uint8_t *buffer = (Byte*)malloc(image_representation.size);
        NSUInteger length = [image_representation getBytes:buffer fromOffset: 0.0  length:image_representation.size error:nil];
        
        if (length != 0)  {
            // buffer -> NSData object; free buffer afterwards
            NSData *adata = [[NSData alloc] initWithBytesNoCopy:buffer length:image_representation.size freeWhenDone:YES];
            
            // identify image type (jpeg, png, RAW file, ...) using UTI hint
            NSDictionary* sourceOptionsDict = [NSDictionary dictionaryWithObjectsAndKeys:(id)[image_representation UTI] ,kCGImageSourceTypeIdentifierHint,nil];
            
            // create CGImageSource with NSData
            CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef) adata,  (__bridge CFDictionaryRef) sourceOptionsDict);
            
            // get imagePropertiesDictionary
            CFDictionaryRef imagePropertiesDictionary;
            imagePropertiesDictionary = CGImageSourceCopyPropertiesAtIndex(sourceRef, 0, NULL);
            
            // get exif data
            CFDictionaryRef exif = (CFDictionaryRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyExifDictionary);
            CFDictionaryRef tiff = (CFDictionaryRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyTIFFDictionary);
            CFDictionaryRef gps = (CFDictionaryRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyGPSDictionary);
            
            NSDictionary *exif_dict = (__bridge NSDictionary* )exif;
            NSDictionary *tiff_dict = (__bridge NSDictionary *)tiff;
            NSDictionary *gps_dict = (__bridge NSDictionary *)gps;
            
            NSString *cameraModel = [NSString stringWithFormat:@"camera: %@ %@", [tiff_dict objectForKey:(id)kCGImagePropertyTIFFMake], [tiff_dict objectForKey:(id)kCGImagePropertyTIFFModel]];
            
            NSLog(@"camera: %@", cameraModel);
            NSLog(@"tiff_dict: %@", tiff_dict);
            NSLog(@"exif_dict: %@", exif_dict);
            NSLog(@"gps_dict: %@", gps_dict);
            
            NSLog(@"processing time: %f", [[NSDate date] timeIntervalSince1970] - timestamp);
            
            // save image WITH meta data
            //                NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            //                NSURL *fileURL = nil;
            //                CGImageRef imageRef = CGImageSourceCreateImageAtIndex(sourceRef, 0, imagePropertiesDictionary);
            //                
            //                if (![[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"] isEqualToString:@"public.tiff"]) {
            //                    fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.%@",
            //                                                      documentsDirectory,
            //                                                      @"myimage",
            //                                                      [[[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"] componentsSeparatedByString:@"."] objectAtIndex:1]
            //                                                      ]];
            //                    
            //                    CGImageDestinationRef dr = CGImageDestinationCreateWithURL ((__bridge CFURLRef)fileURL,
            //                                                                                (__bridge CFStringRef)[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"],
            //                                                                                1,
            //                                                                                NULL
            //                                                                                );
            //                    CGImageDestinationAddImage(dr, imageRef, imagePropertiesDictionary);
            //                    CGImageDestinationFinalize(dr);
            //                    CFRelease(dr);
            //                } else {
            //                    NSLog(@"no valid kCGImageSourceTypeIdentifierHint found …");
            //                }
            
            // clean up
            //                CFRelease(imageRef);
            CFRelease(imagePropertiesDictionary);
            CFRelease(sourceRef);
            
            [lock lock];
            [lock unlockWithCondition:1];
        } else {
            NSLog(@"image_representation buffer length == 0");
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSLog(@"couldn't get asset: %@", error);
    };
    
    [assetsLibrary assetForURL:url resultBlock:resultBlock failureBlock:failureBlock];
}

@end