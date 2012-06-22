//
//  Networking.m
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Networking.h"
#import "AFJSONUtilities.h"
#import "NSString+Base64.h"

@interface Networking ()
@property (nonatomic,strong) NSOperationQueue *httpQueue;
@property (nonatomic,strong) NSURL *url;
@end

@implementation Networking
@synthesize httpQueue = _httpQueue;
@synthesize url = _url;

+ (Networking *)sharedNetworking
{
    static dispatch_once_t once;
    static Networking *instanceOfNetworking;
    dispatch_once(&once, ^ { instanceOfNetworking = [[Networking alloc] init]; });
    return instanceOfNetworking;
}

- (id)init
{
    if (self = [super init]) {
        self.httpQueue = [[NSOperationQueue alloc] init];
        self.url = [NSURL URLWithString:@"http://hackkrk-guess.herokuapp.com"];
    }
    return self;
}


- (void)sendRegisterRequestWithUsername:(NSString *)username password:(NSString *)password withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:self.url];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            username, @"username",
                            password, @"password",
                            nil];

    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/user" parameters:nil];
    NSData *jsonData = AFJSONEncode(params, nil);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
    
    
}

- (void)sendLoginRequestWithUsername:(NSString *)username password:(NSString *)password withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:self.url];
    
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
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:self.url];
    [httpClient setDefaultHeader:@"X-Auth-Token" value:token];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            question, @"question",
                            answer, @"answer",
                            base64Image, @"photo",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/riddles" parameters:nil];
    NSData *jsonData = AFJSONEncode(params, nil);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];

    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

- (void)sendListOfRiddleRequestWithPageNumber:(NSNumber *)pageNumber itemsPerPage:(NSNumber *)itemsPerPage token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:self.url];
    [httpClient setDefaultHeader:@"X-Auth-Token" value:token];
//    [httpClient setDefaultHeader:@"Content-Type" value:@"application/json"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            pageNumber, @"page",
                            [NSNumber numberWithInt:10], @"per_page",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"/riddles" parameters:params];
//    NSData *jsonData = AFJSONEncode(params, nil);
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:jsonData];
    
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON: %@",JSON);
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
         NSLog(@"ERR: %@",error);
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

- (void)postRiddleAnswer:(NSString *)answer riddleID:(NSNumber *)riddleID token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:self.url];
    [httpClient setDefaultHeader:@"X-Auth-Token" value:token];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            answer, @"answer",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[NSString stringWithFormat:@"/riddles/%@/answer",riddleID] parameters:nil];
    NSData *jsonData = AFJSONEncode(params, nil);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}

- (void)leaderboardListWithPageNumber:(NSNumber *)pageNumber itemsPerPage:(NSNumber *)itemsPerPage token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:self.url];
    [httpClient setDefaultHeader:@"X-Auth-Token" value:token];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            pageNumber, @"page",
                            itemsPerPage, @"per_page",
                            nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"/leaderboard" parameters:nil];
    NSData *jsonData = AFJSONEncode(params, nil);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    
    AFJSONRequestOperation *json = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        result(YES,nil,JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        result(NO,error,JSON);
    }];
    
    [self.httpQueue addOperation:json];
}



@end
