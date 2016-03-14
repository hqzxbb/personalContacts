//
//  HBAddViewController.h
//  私人通讯录0430
//
//  Created by 黄宾宾 on 4/30/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBAddViewController,HBContact;
@protocol HBAddViewControllerDelegate <NSObject>
@optional
-(void)addViewController:(HBAddViewController *)addViewController addContact:(HBContact *)contact;
@end
@interface HBAddViewController : UIViewController
@property (nonatomic,strong) id <HBAddViewControllerDelegate> delegate;
@end
