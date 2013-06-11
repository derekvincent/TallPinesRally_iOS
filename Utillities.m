//
//  Utillities.m
//  TallPinesRally
//
//  Created by Derek Vincent on 2012-11-03.
//  Copyright (c) 2012 Derek Vincent. All rights reserved.
//

#import "Utillities.h"
#define TMP NSTemporaryDirectory()

@implementation Utillities

-(void) cacheImage: (NSString *) ImageURLString imageName: (NSString *) ImageName
{
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    NSString *filename = ImageName;
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        // If the file does not exists then we should get a copy and cache it...
        
        //Fetch the image
        NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
        UIImage *image = [[UIImage alloc] initWithData:data];
        
        if([ImageURLString rangeOfString: @".png" options: NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [UIImagePNGRepresentation(image) writeToFile:uniquePath atomically:YES];
        }
        else if (
                 [ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound ||
                 [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
                 )
        {
            [UIImageJPEGRepresentation(image, 100) writeToFile:uniquePath atomically: YES];
        }
    }
}

-(UIImage *) getCachedImage:(NSString *)ImageURLString imageName:(NSString *)ImageName
{
    NSString *filename = ImageName;
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
    
    UIImage *image;
    
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath])
    {
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
    
    else{
        [self cacheImage: ImageURLString imageName:ImageName];
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
    
    return image; 
}
@end
