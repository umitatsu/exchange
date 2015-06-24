//
//  TableViewCell.h
//  exchange
//
//  Created by 海野 竜也 on 2015/04/29.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flagView;
@property (weak, nonatomic) IBOutlet UILabel *contryName;


@end
