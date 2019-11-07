//
//  UserStatisticsManager.m
//  AutoLayoutCell
//
//  Created by taishu on 2019/11/7.
//  Copyright © 2019 taishu. All rights reserved.
//

#import "UserStatisticsManager.h"

@implementation UserStatisticsManager

+ (void)sendEventToServer:(NSString *)eventID {
    //这里发送信息给服务端
    NSLog(@"模拟发送统计事件给服务端，事件eventID为：%@",eventID);
}

+ (NSDictionary *)getDicFromPlist {
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WGlobalUserStatisticsConfig" ofType:@"plist"]];
    return dic;
}

@end
