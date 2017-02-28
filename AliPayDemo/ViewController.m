//
//  ViewController.m
//  AliPayDemo
//
//  Created by James Hsu on 8/11/15.
//  Copyright (c) 2015 James Hsu. All rights reserved.
//

#import "ViewController.h"

#import <AlipaySDK/AlipaySDK.h>
#import "AFNetworking.h"
#import "Model.h"

@interface ViewController () <UIActionSheetDelegate>

@property (nonatomic, weak) UIButton *btn;

@property (nonatomic, weak) UITextField *textField;

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextField *txt = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.5 - 50, self.view.frame.size.height * 0.5 - 150, 100, 30)];
    txt.backgroundColor = [UIColor lightGrayColor];
    txt.borderStyle = UITextBorderStyleRoundedRect;
    txt.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [txt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:txt];
    self.textField = txt;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"支付金额:";
    label.frame = CGRectMake(CGRectGetMinX(self.textField.frame) - 80, self.view.frame.size.height * 0.5 - 150, 100, 30);
    [self.view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.frame.size.width * 0.5 - 50, self.view.frame.size.height * 0.5 - 50, 100, 50);
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"支付" forState: UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(alertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {

        Model *model = [[Model alloc] init];
        
        [model configAlipayWithPayTypeID:@"1"
                               studentID:@"147"
                                   price:self.textField.text
                             description:@""
                                   title:@""
                           studentAvatar:@""
                              schoolName:@""
                             studentName:@""];
        
    } else {
        return;
    }
}

#pragma mark - Private
/**
 *  弹出支付框
 */
- (void)alertView
{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:[NSString
                                                stringWithFormat:@"确认支付 %@ 元", self.textField.text]
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                          destructiveButtonTitle:@"支付"
                                               otherButtonTitles:nil, nil];
    [action showInView:self.view];
}

/**
 *  支付状态
 *
 *  @param message 状态名称
 */
- (void)enterAlertView:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

// 监听按钮事件
-(void)textFieldDidChange:(id)sender
{
    NSLog(@"%@", self.textField.text);
    
    if ([self.textField.text isEqualToString:@""]) {
        [self.btn setBackgroundColor:[UIColor redColor]];
        self.btn.userInteractionEnabled = NO;
    } else {
        [self.btn setBackgroundColor:[UIColor greenColor]];
        self.btn.userInteractionEnabled = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField endEditing:YES];
}

@end
