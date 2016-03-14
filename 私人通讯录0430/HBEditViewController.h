//
//  HBEditViewController.h
//  私人通讯录0430
//
//  Created by 黄宾宾 on 4/30/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBContact,HBEditViewController;
@protocol HBEditViewControllerDelegate <NSObject>
@optional
-(void)editViewController:(HBEditViewController *)editVc saveContact:(HBContact *)contact;
@end
@interface HBEditViewController : UIViewController
@property (nonatomic,strong)HBContact *contact;
@property (nonatomic,weak) id <HBEditViewControllerDelegate> delegate;
@end
