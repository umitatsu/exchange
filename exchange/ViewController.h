//
//  ViewController.h
//  exchange
//
//  Created by 海野 竜也 on 2015/04/26.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain)NSMutableArray *exchanges;
@property(nonatomic,retain)NSMutableArray *cellLabelName;
@property(nonatomic,retain)NSMutableArray *cellImage;
@property(nonatomic,retain)UITableView *table;

@end

