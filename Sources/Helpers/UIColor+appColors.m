//
//  UIColor+appColors.m
//  SyncClient
//
//  Created by Dmitry Zozulya on 11.02.14.
//
//

#import "UIColor+appColors.h"

@implementation UIColor (appColors)

+ (UIColor *)screenBackgroundColor
{
    return [UIColor colorWithRed:73/255
                    green:169/255
                     blue:220/255
                    alpha:1];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
