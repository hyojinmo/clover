
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController : UIViewController {
    
@protected
    
    ALAssetsLibrary *assetsLibrary;
    NSMutableArray *assetsList;
}

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, retain) NSMutableArray *assetsList;

@end
