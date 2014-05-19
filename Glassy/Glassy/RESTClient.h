//
//  RESTClient.h
//  Glassy
//
//  Created by Niek Willems on 29/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RESTClient;

@protocol RestClientDelegate

@required

- (void)restRequestSucceeded:(NSMutableDictionary *)responseDictionary withClient:(RESTClient *)client;
- (void)restRequestFailed:(NSString *)failedMessage withClient:(RESTClient *)client;

@end

@interface RESTClient : NSObject <NSURLConnectionDataDelegate> {
    __weak id delegate;
}

@property (weak) id <RestClientDelegate> delegate;

@property (strong, nonatomic) NSMutableDictionary *response;

- (void)POST:(NSString *)url withParameters:(NSMutableDictionary *)params;
- (void)GET:(NSString *)url withParameters:(NSMutableDictionary *)params;
- (void)PUT:(NSString *)url withParameters:(NSMutableDictionary *)params;

@end
