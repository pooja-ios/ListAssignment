//
//  APIManeger.m
//  ListAssignment
//
//  Created by pooja on 30/11/2017.
//  Copyright © 2017 pooja. All rights reserved.
//

#import "APIManeger.h"
#import "CommonMethods.h"

@implementation APIManeger

+ (APIManeger *)getAPIManager {
    __strong static APIManeger *manager;
    static dispatch_once_t onceToken; dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

-(void)fetchData:(NSString *)URL done:(void (^)(id))block
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                         
                                         if (error != nil) {
                                             
                                             //handle error
                                             [CommonMethods showErrorAlert:error.localizedDescription];
                                         }
                                         else
                                         {
                                             block([CommonMethods dataFromJSON:data]);
                                         }
                                    }] resume];
}
@end
