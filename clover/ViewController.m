
#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize assetsLibrary;
@synthesize assetsList;

- (id) init {
    
    if(self != nil) {
        
        ALAssetsLibrary *newLibray = [[ALAssetsLibrary alloc] init];
        assetsLibrary = [newLibray retain];
        [newLibray release];
        
        assetsList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
     
        usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                
            if (group != nil) { 
                
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                
                    if (result!=nil) { 
                        
                        [self.assetsList addObject:result];
                    } 
                }]; 
            }
            
        }
       failureBlock:^(NSError *error) { NSLog(@"failure: %@", [error description]) ; }]; 
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // test
}

- (void)dealloc {
    
    [assetsLibrary release];
    [assetsList release];
    [super dealloc];
}

@end
