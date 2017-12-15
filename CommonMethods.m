//
//  CommonMethods.m
//  ListAssignment
//
//  Created by pooja on 30/11/2017.
//  Copyright © 2017 pooja. All rights reserved.
//


#import "CommonMethods.h"

#import <UIKit/UIKit.h>

@implementation CommonMethods

+ (id)dataFromJSON:(id)json {
    if (!json) return nil;
    
    NSData *data = json;
    
    BOOL string = [json isKindOfClass:[NSString class]];
    
    NSAssert(string || [data isKindOfClass:[NSData class]], @"NSStrings and NSData are the supported types ( got %@ ) => %@", [json class], json);
    
    if (string) data = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

+(void)showErrorAlert:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction
                                 actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleCancel
                                 handler:nil];
        
        [alert addAction:action];
        
        UIWindow *window = [[[UIApplication sharedApplication]delegate] window];
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

+(NSString *)getFormattedDate:(NSString *)date
{
    //2017-11-30T10:17:59.000Z
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *dDate = [formatter dateFromString:date];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    if (date) return [formatter stringFromDate:dDate];
    else return @"";
}


@end
