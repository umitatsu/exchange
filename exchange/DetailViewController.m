//
//  DetailViewController.m
//  exchange
//
//  Created by 海野 竜也 on 2015/04/29.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController (){
    BOOL selectedView;
    CGRect originFrame;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.929 green:0.925 blue:0.929 alpha:1.0];
    
    //ジェスチャーの設定
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:gesture];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1000)];
    [self.view addSubview:self.scrollView];
    
    originFrame = self.scrollView.frame;
    
    //テキストフィールドとテキストビューの設定
    self.exchangeView = [[UITextView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 150)];
    NSString *string = [NSString stringWithFormat:@"%@ : %@",self.naviTitle, self.exchange];
    self.exchangeView.text = string;
    self.exchangeView.font = [UIFont systemFontOfSize:30.0];
    self.exchangeView.editable = NO;
    
    self.resultView = [[UITextView alloc]initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 100)];
    self.resultView.font = [UIFont systemFontOfSize:20.0];
    self.resultView.editable = NO;
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 40)];
    self.textField.placeholder = @"入力された値を円に変換します";
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.scrollView addSubview: self.exchangeView];
    [self.scrollView addSubview: self.resultView];
    [self.scrollView addSubview: self.textField];
    
    [self registerForKeyboardNotifications];
    
    /*[self.view addSubview: self.exchangeView];
    [self.view addSubview: self.resultView];
    [self.view addSubview: self.textField];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    title.textColor = [UIColor blackColor];
    title.text = self.naviTitle;
    title.font = [UIFont boldSystemFontOfSize:16.0];
    self.navigationItem.titleView = title;
}

//為替の計算
- (float)calc: (float)yen{
    float ans = yen * [self.exchange floatValue];
    return ans;
}

//テキストビューのデリゲート
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *nowText;
    if ([string isEqualToString:@""]) {
        nowText = [self.textField.text substringToIndex:self.textField.text.length - 1];
    }else{
        nowText = [NSString stringWithFormat:@"%@%@",self.textField.text,string];
    }
    NSLog(@"string = %@ text = %@ text2 = %@ length = %lu location = %lu",string,self.textField.text,nowText,(unsigned long)range.length,(unsigned long)range.location);
    float ans = [self calc: [nowText floatValue]];
    self.resultView.text = [NSString stringWithFormat:@"%f円",ans];
    return YES;
}

//キーボードを引っ込める処理
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    selectedView = YES;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    selectedView = NO;
    return YES;
}



- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

//隠れた部分を表示
- (void)keyboardWasShown:(NSNotification*)notification{
    if (selectedView) {
        NSLog(@"test");
        NSDictionary *infoDic = [notification userInfo];
        CGRect keyboardFrame = [infoDic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        float screenHeight = screenBounds.size.height;
        [UIView animateWithDuration: 0.3 animations: ^{
            self.scrollView.frame =  CGRectMake(0, -230, self.scrollView.frame.size.width , self.scrollView.frame.size.height);
        }];
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification*)notification{
    self.scrollView.frame = originFrame;
}

-(void)singleTap:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
