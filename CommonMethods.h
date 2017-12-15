//
//  CommonMethods.h
//  ListAssignment
//
//  Created by pooja on 30/11/2017.
//  Copyright © 2017 pooja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonMethods : NSObject

+ (id)dataFromJSON:(id)json;
+(void)showErrorAlert:(NSString *)message;
+(NSString *)getFormattedDate:(NSString *)date;

@end
