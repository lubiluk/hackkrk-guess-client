//
//  UserAuthentication.m
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UserAuthentication.h"

@implementation UserAuthentication
@synthesize username = _username;
@synthesize token = _token;
@synthesize score;

+ (UserAuthentication *)sharedAuthentication
{
    static dispatch_once_t once;
    static UserAuthentication *instanceOfUserAuthentication;
    dispatch_once(&once, ^ { instanceOfUserAuthentication = [[UserAuthentication alloc] init]; });
    return instanceOfUserAuthentication;
}



@end
