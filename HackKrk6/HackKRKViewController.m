//
//  ios6ViewController.m
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HackKRKViewController.h"
#import "AFNetworking.h"

@interface HackKRKViewController ()

@end

@implementation HackKRKViewController




- (void)sendRegisterWithUsername:(NSString *)username password:(NSString *)password requestWithCallBack:(void (^)(BOOL result, NSError *error, id JSON))result
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
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:json];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self sendRegisterWithUsername:@"mientus" password:@"hackkrk" requestWithCallBack:^(BOOL result, NSError *error, id JSON) {
        NSLog(@"%@",JSON); 
    }];
// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
