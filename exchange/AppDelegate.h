//
//  AppDelegate.h
//  exchange
//
//  Created by 海野 竜也 on 2015/04/26.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *naviController;
    ViewController *topController;
    NSMutableArray *viewControllers;
}

@property (strong, nonatomic) UIWindow *window;


@end

