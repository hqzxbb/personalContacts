//
//  HBContactCell.h
//  私人通讯录0430
//
//  Created by 黄宾宾 on 5/1/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBContact;
@interface HBContactCell : UITableViewCell
@property (nonatomic,strong)HBContact *contact;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
