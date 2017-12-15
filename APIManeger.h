//
//  APIManeger.h
//  ListAssignment
//
//  Created by pooja on 30/11/2017.
//  Copyright © 2017 pooja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManeger : NSObject

+ (APIManeger *)getAPIManager;
-(void)fetchData:(NSString *)URL done:(void (^)(id))block;

@end
