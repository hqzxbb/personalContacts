//
//  HBAddViewController.m
//  私人通讯录0430
//
//  Created by 黄宾宾 on 4/30/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBAddViewController.h"
#import "HBContact.h"
@interface HBAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *addContact;
- (IBAction)backgroundTap;
- (IBAction)addContactClick;


@end

@implementation HBAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //监听通知，得到文字修改的通知就调用方法
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    //让姓名文本框称为第一响应者

    
}
/**
 *  控制器的view完全显示之后执行
 */
-(void)viewDidAppear:(BOOL)animated{
    [self.nameField becomeFirstResponder];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/**
 *  文本框的文字发生改变的时候调用这个方法把addContact按钮改为可点击状态
 */
-(void)textChange{
    self.addContact.enabled=(self.nameField.text.length&&self.phoneField.text.length);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)backgroundTap {
    [self.view endEditing:YES];
}

- (IBAction)addContactClick {
    //关闭当前控制器
    [self.navigationController  popViewControllerAnimated:YES];
    //传递数据给上一个控制器（HBContactViewController）
    //通知代理
    if ([self.delegate respondsToSelector:@selector(addViewController:addContact:)]) {
        HBContact *contact=[[HBContact alloc]init];
        contact.name=self.nameField.text;
        contact.phone=self.phoneField.text;
        [self.delegate addViewController:self addContact:contact];
    }
    
}


@end
