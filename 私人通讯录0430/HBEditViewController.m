//
//  HBEditViewController.m
//  私人通讯录0430
//
//  Created by 黄宾宾 on 4/30/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBEditViewController.h"
#import "HBContact.h"

@interface HBEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveB;

- (IBAction)saveBtn;
- (IBAction)editBtn:(UIBarButtonItem *)sender;

@end

@implementation HBEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameField.text=self.contact.name;
    self.phoneField.text=self.contact.phone;
    //通知   文本框改变保存按钮的状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    
}
-(void)textChange{
    self.saveB.enabled=(self.nameField.text.length&&self.phoneField.text.length);
}


/**
 *  不能在这个方法中加载控件的数据，因为这个时候view还没有创建
 *  即使加载了数据，也会在创建的时候被覆盖掉，应该在viewDidLoad中设置数据
 */
//-(void)setContact:(HBContact *)contact{
//    _contact=contact;
//    self.nameField.text=contact.name;
//    self.phoneField.text=contact.phone;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBtn {
    //关闭当前控制器
    [self.navigationController popViewControllerAnimated:YES];
    //调用代理方法逆向传值
    if ([self.delegate respondsToSelector:@selector(editViewController:saveContact:)]) {
        self.contact.name=self.nameField.text;
        self.contact.phone=self.phoneField.text;
        [self.delegate editViewController:self saveContact:self.contact];
    }
}

- (IBAction)editBtn:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        self.saveB.hidden=NO;
        self.nameField.enabled=YES;
        self.phoneField.enabled=YES;
        [self.phoneField becomeFirstResponder];
        sender.title=@"取消";
    }else if ([sender.title isEqualToString:@"取消"]){
        self.saveB.hidden=YES;
        self.nameField.text=self.contact.name;
        self.phoneField.text=self.contact.phone;
        self.nameField.enabled=NO;
        self.phoneField.enabled=NO;
        [self.phoneField resignFirstResponder];
        sender.title=@"编辑";
    }
    
}
@end
