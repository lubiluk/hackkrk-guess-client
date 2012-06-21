//
//  Networking.m
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Networking.h"
#import "NSString+Base64.h"

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

- (void)uploadRiddleWithQuestion:(NSString *)question answer:(NSString *)answer token:(NSString *)token photo:(UIImage *)photo withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    
    NSData *dataForJPEGFile = UIImageJPEGRepresentation(photo, 0.9f);
    
    NSString *base64Image = [NSString encodeBase64WithData:dataForJPEGFile];
    
    
    NSURL *url = [NSURL URLWithString:@"http://hackkrk-guess-static.herokuapp.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setDefaultHeader:@"X-Auth-Token" value:token];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            question, @"question",
                            answer, @"answer",
                            base64Image, @"photo",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/riddles" parameters:params];

    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

- (void)sendListOfRiddleRequestWithPageNumber:(NSNumber *)pageNumber itemsPerPage:(NSNumber *)itemsPerPage token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    NSURL *url = [NSURL URLWithString:@"http://hackkrk-guess-static.herokuapp.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setDefaultHeader:@"X-Auth-Token" value:token];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            pageNumber, @"page",
                            itemsPerPage, @"per_page",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"/riddles" parameters:params];
    
    
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

- (void)postRiddleAnswer:(NSString *)answer riddleID:(NSNumber *)riddleID token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    NSURL *url = [NSURL URLWithString:@"http://hackkrk-guess-static.herokuapp.com"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    [httpClient setDefaultHeader:@"X-Auth-Token" value:token];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            answer, @"answer",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[NSString stringWithFormat:@"/riddles/%@/answer",riddleID] parameters:params];
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

@end
