//
//  ViewController.m
//  exchange
//
//  Created by 海野 竜也 on 2015/04/26.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#define JPY @"JPY"//日本 円
#define USD @"USD"//アメリカ ドル
#define EUR @"EUR"//EU ユーロ
#define CNY @"CNY"//中国 元
#define GBP @"GBP"//イギリス ポンド
#define RUB @"RUB"//ロシア ルーブル
#define KRW @"KRW"//韓国 ウォン
#define CHF @"CHF"//スイス　フラン
#define MXN @"MXN"//メキシコ ペソ

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    //NSString *origin = @"http://www.freecurrencyconverterapi.com/api/v2/convert?";
    //NSString *usdStUrl = [NSString stringWithFormat:@"%@q=%@_%@&compact=y",origin,USD,JPY];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    title.textColor = [UIColor blackColor];
    title.text = @"通貨一覧";
    title.font = [UIFont boldSystemFontOfSize:16.0];
    self.navigationItem.titleView = title;
    
    //ナビゲーションの設定
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.929 green:0.925 blue:0.929 alpha:0.3];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.exchanges = [[NSMutableArray alloc]init];
    
    //tableViewの設定
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.table];
    
    //カスタムセルの設定
    UINib *nib = [UINib nibWithNibName:@"tableViewCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"Cell"];
    
    
    self.cellLabelName = [[NSMutableArray alloc]initWithObjects:@"米ドル/円",@"ユーロ/円",@"元/円",@"ポンド/円",@"ルーブル/円",@"ウォン/円",@"スイスフラン/円",@"メキシコペソ/円", nil];
    self.cellImage = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"usa.png"],[UIImage imageNamed:@"euro.png"],[UIImage imageNamed:@"china.png"],[UIImage imageNamed:@"uk.png"],[UIImage imageNamed:@"russia.png"],[UIImage imageNamed:@"korea.png"],[UIImage imageNamed:@"switzerland.png"],[UIImage imageNamed:@"mexico.png"], nil];
    
    //APIのURLを設定
    NSString *origin = @"http://api.aoikujira.com/kawase/json";
    NSString *usdStUrl = [NSString stringWithFormat:@"%@/%@",origin,USD];
    NSString *eurStUrl = [NSString stringWithFormat:@"%@/%@",origin,EUR];
    NSString *cnyStUrl = [NSString stringWithFormat:@"%@/%@",origin,CNY];
    NSString *gbpStUrl = [NSString stringWithFormat:@"%@/%@",origin,GBP];
    NSString *rubStUrl = [NSString stringWithFormat:@"%@/%@",origin,RUB];
    NSString *krwStUrl = [NSString stringWithFormat:@"%@/%@",origin,KRW];
    NSString *chfStUrl = [NSString stringWithFormat:@"%@/%@",origin,CHF];
    NSString *mxnStUrl = [NSString stringWithFormat:@"%@/%@",origin,MXN];
    
    
    NSURL *usdUrl = [NSURL URLWithString:usdStUrl];
    NSURL *eurUrl = [NSURL URLWithString:eurStUrl];
    NSURL *cnyUrl = [NSURL URLWithString:cnyStUrl];
    NSURL *gbpUrl = [NSURL URLWithString:gbpStUrl];
    NSURL *rubUrl = [NSURL URLWithString:rubStUrl];
    NSURL *krwUrl = [NSURL URLWithString:krwStUrl];
    NSURL *chfUrl = [NSURL URLWithString:chfStUrl];
    NSURL *mxnUrl = [NSURL URLWithString:mxnStUrl];
    
    NSURLRequest *usdRequest = [[NSURLRequest alloc]initWithURL:usdUrl];
    NSURLRequest *eurRequest = [[NSURLRequest alloc]initWithURL:eurUrl];
    NSURLRequest *cnyRequest = [[NSURLRequest alloc]initWithURL:cnyUrl];
    NSURLRequest *gbpRequest = [[NSURLRequest alloc]initWithURL:gbpUrl];
    NSURLRequest *rubRequest = [[NSURLRequest alloc]initWithURL:rubUrl];
    NSURLRequest *krwRequest = [[NSURLRequest alloc]initWithURL:krwUrl];
    NSURLRequest *chfRequest = [[NSURLRequest alloc]initWithURL:chfUrl];
    NSURLRequest *mxnRequest = [[NSURLRequest alloc]initWithURL:mxnUrl];
    
    
    //同期処理
    NSData *usdJson = [NSURLConnection sendSynchronousRequest:usdRequest returningResponse:nil error:nil];
    NSData *eurJson = [NSURLConnection sendSynchronousRequest:eurRequest returningResponse:nil error:nil];
    NSData *cnyJson = [NSURLConnection sendSynchronousRequest:cnyRequest returningResponse:nil error:nil];
    NSData *gbpJson = [NSURLConnection sendSynchronousRequest:gbpRequest returningResponse:nil error:nil];
    NSData *rubJson = [NSURLConnection sendSynchronousRequest:rubRequest returningResponse:nil error:nil];
    NSData *krwJson = [NSURLConnection sendSynchronousRequest:krwRequest returningResponse:nil error:nil];
    NSData *chfJson = [NSURLConnection sendSynchronousRequest:chfRequest returningResponse:nil error:nil];
    NSData *mxnJson = [NSURLConnection sendSynchronousRequest:mxnRequest returningResponse:nil error:nil];

    //JSONを構造化する
    NSMutableArray *usdArray = [NSJSONSerialization JSONObjectWithData:usdJson options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *eurArray = [NSJSONSerialization JSONObjectWithData:eurJson options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *cnyArray = [NSJSONSerialization JSONObjectWithData:cnyJson options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *gbpArray = [NSJSONSerialization JSONObjectWithData:gbpJson options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *rubArray = [NSJSONSerialization JSONObjectWithData:rubJson options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *krwArray = [NSJSONSerialization JSONObjectWithData:krwJson options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *chfArray = [NSJSONSerialization JSONObjectWithData:chfJson options:NSJSONReadingAllowFragments error:nil];
    NSMutableArray *mxnArray = [NSJSONSerialization JSONObjectWithData:mxnJson options:NSJSONReadingAllowFragments error:nil];
    
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[usdArray valueForKeyPath:@"JPY"]]];
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[eurArray valueForKeyPath:@"JPY"]]];
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[cnyArray valueForKeyPath:@"JPY"]]];
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[gbpArray valueForKeyPath:@"JPY"]]];
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[rubArray valueForKeyPath:@"JPY"]]];
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[krwArray valueForKeyPath:@"JPY"]]];
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[chfArray valueForKeyPath:@"JPY"]]];
    [self.exchanges addObject: [NSString stringWithFormat:@"%@",[mxnArray valueForKeyPath:@"JPY"]]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //非同期処理
    /*[NSURLConnection  sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler: ^(NSURLResponse *response, NSData *json, NSError *error){
        if (error) {
            if (error.code == -1003) {
                NSLog(@"not found hostname. targetURL = %@", usdUrl);
            }else if (-1019) {
                NSLog(@"auth error. reason = %@",error);
            }else {
                NSLog(@"unknown error occurred. reason = %@",error);
            }
        } else {
            int httpStatusCode = ((NSHTTPURLResponse *)response).statusCode;
            if (httpStatusCode == 404) {
                NSLog(@"404 NOT FOUND ERROR. targetURL=%@", usdUrl);
            } else {
                NSLog(@"success request!!");
                NSLog(@"statusCode = %ld", (long)((NSHTTPURLResponse *)response).statusCode);
                NSMutableArray *dataArray = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
                NSString *string = [NSString stringWithFormat:@"%@",[dataArray valueForKeyPath:@"JPY"]];
                
                NSLog(@"data = %@",string);
                
                label.text = string;
            }
        }
    }];*/
}


//tableViewのデリゲート
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.contryName.text = self.cellLabelName[indexPath.row];
    cell.flagView.image = self.cellImage[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *detailController = [[DetailViewController alloc]init];
    detailController.naviTitle = self.cellLabelName[indexPath.row];
    detailController.exchange = self.exchanges[indexPath.row];
    if (detailController) {
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
