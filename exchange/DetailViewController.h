//
//  DetailViewController.h
//  exchange
//
//  Created by 海野 竜也 on 2015/04/29.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,retain)NSString *naviTitle;
@property(nonatomic,retain)NSString *exchange;
@property(nonatomic,retain)UITextView *exchangeView;
@property(nonatomic,retain)UITextField *textField;
@property(nonatomic,retain)UITextView *resultView;
@property(nonatomic,retain)UIScrollView *scrollView;


@end
