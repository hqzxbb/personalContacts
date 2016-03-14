//
//  HBConectTableViewController.m
//  私人通讯录0430
//
//  Created by 黄宾宾 on 4/30/15.
//  Copyright (c) 2015 HB. All rights reserved.
//

#import "HBContactsTableViewController.h"
#import "HBAddViewController.h"
#import "HBContact.h"
#import "HBEditViewController.h"
#import "HBContactCell.h"
//文件路径
#define HBContactsFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]

@interface HBContactsTableViewController ()<UIActionSheetDelegate,HBAddViewControllerDelegate,HBEditViewControllerDelegate>
- (IBAction)logout:(id)sender;
@property (nonatomic,strong)NSMutableArray *contacts;

@end

@implementation HBContactsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    //添加一个删除item
    UIBarButtonItem *addItem=self.navigationItem.rightBarButtonItem;
    UIBarButtonItem *deleteItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteClick)];
    self.navigationItem.rightBarButtonItems=@[deleteItem,addItem];
}
-(void)deleteClick{
    //让tableView进入编辑状态
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
-(NSMutableArray *)contacts{
    if (_contacts==nil) {
        //从文件中读取联系人数据
        _contacts=[NSKeyedUnarchiver unarchiveObjectWithFile:HBContactsFilepath];
        if (_contacts==nil) {
            //文件不存在
            _contacts=[NSMutableArray array];
        }
    }
    return _contacts;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //创建cell
    HBContactCell *cell=[HBContactCell cellWithTableView:tableView];
    //设置数据
    cell.contact=self.contacts[indexPath.row];
    
    return cell;
}

- (IBAction)logout:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:@"确定要注销？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}
/**
 *  设置代理,传值
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc=segue.destinationViewController;
    if ([vc isKindOfClass:[HBAddViewController class]]) {
        HBAddViewController *addViewControll=vc;
        addViewControll.delegate=self;
    }else if ([vc isKindOfClass:[HBEditViewController class]]){
        HBEditViewController *editViewController =vc;
        NSIndexPath *indexP=[self.tableView indexPathForSelectedRow];
        editViewController.contact=self.contacts[indexP.row];
        editViewController.delegate=self;
    }
    
}

#pragma  mark - actionsheet的代理方法
/**
 *  点击底部弹出的警告上的按钮，执行pop操作
 */
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - HBAddViewController代理方法
-(void)addViewController:(HBAddViewController *)addViewController addContact:(HBContact *)contact{
    
    //添加模型数据
    [self.contacts addObject:contact];
    //刷新数据
    [self.tableView reloadData];
    //归档数组
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:HBContactsFilepath];
}
#pragma mark - HBEditViewController代理方法
-(void)editViewController:(HBEditViewController *)editVc saveContact:(HBContact *)contact{
    //因为这个contact对象指向的就是_contacts可变数组中的一个对象，修改contact就等于修改了_contacts可变数组中的值，因为不用更新数据
    //刷新数据
    [self.tableView reloadData];
    //归档数组
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:HBContactsFilepath];
}

#pragma mark tableView的代理方法
/**
 *  如果实现了这个方法，就自动实现了滑动删除的功能
 *  点击了操作按钮就会调用 {None/Insert(添加)/Delete(删除)}
 *  操作按钮就是滑动之后出现的按钮
 *
 *  @param tableView    要操作的tableview
 *  @param editingStyle 编辑的行为
 *  @param indexPath    操作的行号
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //删除模型数据
        [self.contacts removeObjectAtIndex:indexPath.row];
        //刷新表格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        //归档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:HBContactsFilepath];
    }
}

@end
