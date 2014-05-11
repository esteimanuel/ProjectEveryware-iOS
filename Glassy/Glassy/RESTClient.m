//
//  RESTClient.m
//  Glassy
//
//  Created by Niek Willems on 29/04/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "RESTClient.h"

@interface RESTClient ()

@property (nonatomic, strong) NSMutableData *buffer;
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation RESTClient

- (void)POST:(NSString *)url withParameters:(NSMutableDictionary *)params
{
    // Create the request from given URL
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    // Specify post request
    [request setHTTPMethod:@"POST"];
    // Set header fields
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // Set request body
    NSError *error = nil;
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    [request setHTTPBody:requestBodyData];
    // Start the connection
    [self startConnection:request];
}

- (void)GET:(NSString *)url withParameters:(NSMutableDictionary *)params
{
    NSLog(@"GET");
    NSMutableString *fullUrl = [[NSMutableString alloc] initWithString:url];
    // Concatenate the given URL
    if (params != nil) {
        for(id key in params) {
            [fullUrl appendString:[[NSMutableString alloc] initWithFormat:@"%@=%@&", key, [params objectForKey:key]]];
        }
        // Delete last '&' char
        [fullUrl deleteCharactersInRange:NSMakeRange([fullUrl length]-1, 1)];
    }
    NSMutableURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fullUrl]];
    // Start the connection
    [self startConnection:request];
}

- (void)PUT:(NSString *)url withParameters:(NSMutableDictionary *)params
{
    // Create the request from given URL
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    // Specify post request
    [request setHTTPMethod:@"PUT"];
    // Set header fields
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // Set request body
    NSError *error = nil;
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    [request setHTTPBody:requestBodyData];
    // Start the connection
    [self startConnection:request];
}

- (void)startConnection:(NSMutableURLRequest *)request
{
    // Create connection
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    // Ensure connection was created
    if (self.connection) {
        // Initialize buffer
        self.buffer = [NSMutableData data];
        // Start request
        [self.connection start];
    } else {
        NSLog(@"Failed to start the connection");
    }
}

#pragma mark - URL connection delegate methods

@synthesize delegate;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Clear connection and buffer
    self.connection = nil;
    self.buffer = nil;
    
    if ([delegate respondsToSelector:@selector(restRequestFailed:)]) {
        [delegate restRequestFailed:[error localizedDescription]];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Reset buffer length
    [self.buffer setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append data to buffer
    [self.buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Dispatch from main queue for json processing
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error = nil;
        self.response = [NSJSONSerialization JSONObjectWithData:_buffer options:kNilOptions error:&error];
        
        // Back to main queu
        dispatch_async(dispatch_get_main_queue(), ^{
            // Check for any error
            if (!error) {
                if ([delegate respondsToSelector:@selector(restRequestSucceeded:)]) {
                    [delegate restRequestSucceeded:self.response];
                }
            } else {
                if ([delegate respondsToSelector:@selector(restRequestFailed:)]) {
                    [delegate restRequestFailed:@"Request failed"];
                }
            }
            // Clear connection and buffer
            self.connection = nil;
            self.buffer = nil;
        });
    });
    
}

@end
