//
//  Networking.h
//  HackKrk6
//
//  Created by mientus on 21.06.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Networking : NSObject

- (void)sendRegisterRequestWithUsername:(NSString *)username password:(NSString *)password withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result;

@end
