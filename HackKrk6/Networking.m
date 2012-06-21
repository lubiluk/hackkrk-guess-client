//
//  Networking.m
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Networking.h"

@interface Networking ()
@property (nonatomic,strong) NSOperationQueue *httpQueue;
@end

@implementation Networking
@synthesize httpQueue = _httpQueue;

+ (Networking *)sharedNetworking
{
    static dispatch_once_t once;
    static Networking *instanceOfNetworking;
    dispatch_once(&once, ^ { instanceOfNetworking = [[Networking alloc] init]; });
    return instanceOfNetworking;
}


- (void)sendRegisterRequestWithUsername:(NSString *)username password:(NSString *)password withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    NSURL *url = [NSURL URLWithString:@"http://hackkrk-guess-static.herokuapp.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"username",
                            password, @"password",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/user" parameters:params];
    
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

- (void)sendLoginRequestWithUsername:(NSString *)username password:(NSString *)password withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    NSURL *url = [NSURL URLWithString:@"http://hackkrk-guess-static.herokuapp.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"username",
                            password, @"password",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"/user" parameters:params];
    
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

@end
