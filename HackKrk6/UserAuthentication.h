//
//  UserAuthentication.h
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAuthentication : NSObject
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *token;

+ (UserAuthentication *)sharedAuthentication;
@end
