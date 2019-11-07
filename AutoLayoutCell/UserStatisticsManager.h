//
//  UserStatisticsManager.h
//  AutoLayoutCell
//
//  Created by taishu on 2019/11/7.
//  Copyright © 2019 taishu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserStatisticsManager : NSObject

+ (void)sendEventToServer:(NSString *)eventID;
+ (NSDictionary *)getDicFromPlist;
@end

NS_ASSUME_NONNULL_END
