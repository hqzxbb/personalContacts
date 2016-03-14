//
//  HBContactCell.m
//  私人通讯录0430
//
//  Created by 黄宾宾 on 5/1/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBContactCell.h"
#import "HBContact.h"
@interface HBContactCell()
@property (nonatomic,weak) UIView *divider;
@end

@implementation HBContactCell


-(void)setContact:(HBContact *)contact{
    _contact=contact;
    self.textLabel.text=self.contact.name;
    self.detailTextLabel.text=self.contact.phone;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"contact";
    return [tableView dequeueReusableCellWithIdentifier:ID];
}
/**
 *  如果cell是通过手写代码创建的，才会调用这个方法
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    //如果cell是通过手写代码创建的，才会调用这个方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
/**
 *  如果cell是通过storyboard或者xib创建的就会调用这个方法来初始化cell
 *  这个方法的作用类似于init方法
 */
- (void)awakeFromNib {
    // Initialization code
    UIView *divider=[[UIView alloc]init];
    divider.backgroundColor=[UIColor blackColor];
    divider.alpha=0.3;
    [self.contentView addSubview:divider];
    self.divider=divider;
}

/**
 *  设置子控件的frame
 *  这个方法表示子控件加载完成，开始布局界面，这时设置frame不会被覆盖
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置子控件的frame
    CGFloat dividerX=0;
    CGFloat dividerH=1;
    CGFloat dividerY=self.frame.size.height-dividerH;
    CGFloat dividerW=self.frame.size.width;
    self.divider.frame=CGRectMake(dividerX, dividerY, dividerW, dividerH);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
