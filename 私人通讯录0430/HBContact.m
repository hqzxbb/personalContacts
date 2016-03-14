//
//  HBContact.m
//  私人通讯录0430
//
//  Created by 黄宾宾 on 5/1/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBContact.h"

@implementation HBContact
-(void)encodeWithCoder:(NSCoder *)enCoder{
    [enCoder encodeObject:self.name forKey:@"name"];
    [enCoder encodeObject:self.phone forKey:@"phone"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.name=[aDecoder decodeObjectForKey:@"name"];
        self.phone=[aDecoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
