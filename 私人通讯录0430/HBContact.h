//
//  HBContact.h
//  私人通讯录0430
//
//  Created by 黄宾宾 on 5/1/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBContact : NSObject<NSCoding>
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *phone;

@end
