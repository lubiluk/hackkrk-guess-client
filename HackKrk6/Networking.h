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

+ (Networking *)sharedNetworking;

- (void)sendRegisterRequestWithUsername:(NSString *)username password:(NSString *)password withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result;

- (void)sendLoginRequestWithUsername:(NSString *)username password:(NSString *)password withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result;

- (void)uploadRiddleWithQuestion:(NSString *)question answer:(NSString *)answer token:(NSString *)token photo:(UIImage *)photo withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result;

- (void)sendListOfRiddleRequestWithPageNumber:(NSNumber *)pageNumber itemsPerPage:(NSNumber *)itemsPerPage token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result;

- (void)postRiddleAnswer:(NSString *)answer riddleID:(NSNumber *)riddleID token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result;

- (void)leaderboardListWithPageNumber:(NSNumber *)pageNumber itemsPerPage:(NSNumber *)itemsPerPage token:(NSString *)token withCallBack:(void (^)(BOOL result, NSError *error, id JSON))result;

@end