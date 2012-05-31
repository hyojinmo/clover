//
//  ImagePropertiesLib.m
//  ImagePropertiesLib
//
//  Created by Hyojin Mo on 12. 5. 25..
//  Copyright (c) 2012년 __MyCompanyName__. All rights reserved.
//

#import "ImagePropertiesLib.h"

@implementation ImagePropertiesLib

+ (void) getImagePropertiesUsingBlockWithUrl:(NSURL *)url {
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    ALAssetsLibraryAssetForURLResultBlock resultBlock = ^(ALAsset *asset) {
        [self getImagePropertiesWithAsset:asset];
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error) {
        NSLog(@"couldn't get asset: %@", error);
    };
    
    [assetsLibrary assetForURL:url resultBlock:resultBlock failureBlock:failureBlock];
}

+ (void) getImagePropertiesUsingBlockWithAsset:(ALAsset *)asset {
    dispatch_queue_t propQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(propQueue, ^{
        [self getImagePropertiesWithAsset:asset];
    });
}

+ (void) getImagePropertiesWithAsset:(ALAsset *)asset {
    double timestamp = [[NSDate date] timeIntervalSince1970];
    
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
        
        if (imagePropertiesDictionary) {
            // get exif data
            CFDictionaryRef exif = (CFDictionaryRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyExifDictionary);
            CFDictionaryRef tiff = (CFDictionaryRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyTIFFDictionary);
            CFDictionaryRef gps = (CFDictionaryRef)CFDictionaryGetValue(imagePropertiesDictionary, kCGImagePropertyGPSDictionary);
            
            if (exif) {
                NSDictionary *exif_dict = (__bridge NSDictionary* )exif;
                NSLog(@"exif_dict: %@", exif_dict);
            }
            
            if (tiff) {
                NSDictionary *tiff_dict = (__bridge NSDictionary *)tiff;
                NSLog(@"tiff_dict: %@", tiff_dict);
            }
            
            if (gps) {
                NSDictionary *gps_dict = (__bridge NSDictionary *)gps;
                NSLog(@"gps_dict: %@", gps_dict);
            }
            
            NSLog(@"processing time: %f", [[NSDate date] timeIntervalSince1970] - timestamp);
            
            CFRelease(imagePropertiesDictionary);
        }
        
        CFRelease(sourceRef);
    } else {
        NSLog(@"image_representation buffer length == 0");
    }
}

+ (void) saveImagePropertiesWithAsset:(ALAsset *)asset {
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
        
        // save image WITH meta data
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSURL *fileURL = nil;
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(sourceRef, 0, imagePropertiesDictionary);
        
        if (![[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"] isEqualToString:@"public.tiff"]) {
            fileURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.%@",
                                              documentsDirectory,
                                              @"myimage",
                                              [[[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"] componentsSeparatedByString:@"."] objectAtIndex:1]
                                              ]];
            
            CGImageDestinationRef dr = CGImageDestinationCreateWithURL ((__bridge CFURLRef)fileURL,
                                                                        (__bridge CFStringRef)[sourceOptionsDict objectForKey:@"kCGImageSourceTypeIdentifierHint"],
                                                                        1,
                                                                        NULL
                                                                        );
            CGImageDestinationAddImage(dr, imageRef, imagePropertiesDictionary);
            CGImageDestinationFinalize(dr);
            CFRelease(dr);
            
            // clean up
            CFRelease(imageRef);
        } else {
            NSLog(@"no valid kCGImageSourceTypeIdentifierHint found …");
        }
        
        CFRelease(imagePropertiesDictionary);
        CFRelease(sourceRef);
    } else {
        NSLog(@"image_representation buffer length == 0");
    }
}

@end
