//
//  UCIGameSettingViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-6-8.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIGameSettingViewController.h"

#define ProductID_VIP1 @"vip1"//6
#define ProductID_VIP2 @"vip2" //12
#define ProductID_VIP3 @"vip3" //18
#define ProductID_VIP4 @"vip4" //30

@interface UCIGameSettingViewController ()

@end

@implementation UCIGameSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    bool soundon=[[self getObjectFromDefault:@"soundon"] boolValue];
//    if(soundon==true||soundon==false){
        self.switchOn.on=soundon;
//    }
    
    //监听支付数据
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    

    // Do any additional setup after loading the view.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    //移除监听
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)sound:(UISwitch *)sender {
    if(sender.isOn){
        [self setObjectFromDefault:@"true" key:@"soundon"];
    }
    else{
        [self setObjectFromDefault:@"false" key:@"soundon"];
    }

}

-(void) buy:(int)type{
    buyType=type;
    if([SKPaymentQueue canMakePayments]){
        [self RequestProductData];
        [self showAlert:@"" content:@"允许内购项目"];
    }
    else{
        [self showAlert:@"" content:@"不允许"];
    }
}

-(void)RequestProductData{
    NSArray * product=nil;
    switch (buyType) {
        case IPAvip1:
            product=[[NSArray alloc] initWithObjects:ProductID_VIP1, nil];
            break;
        default:
            product=[[NSArray alloc] initWithObjects:ProductID_VIP4, nil];
            break;
    }
    NSSet *nsset=[NSSet setWithArray:product];
    SKProductsRequest *request=[[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate=self;
    [request start];
}

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSLog(@"-----------收到产品反馈信息--------------");
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@",response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", [myProduct count]);
    for(SKProduct *product in myProduct){
        NSLog(@"product info");
        NSLog(@"SKProduct 描述信息%@", [product description]);
        NSLog(@"产品标题 %@" , product.localizedTitle);
        NSLog(@"产品描述信息: %@" , product.localizedDescription);
        NSLog(@"价格: %@" , product.price);
        NSLog(@"Product id: %@" , product.productIdentifier);
    }
    SKPayment *payment = nil;
    switch (buyType) {
        case IPAvip1:
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_VIP1];    //支付$0.99
            break;
        case IPAvip2:
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_VIP2];    //支付$1.99
            break;
        case IPAvip3:
            payment  = [SKPayment paymentWithProductIdentifier:ProductID_VIP3];    //支付$9.99
            break;
        default:
            break;
    }
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                NSLog(@"交易失败");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"交易进行中");
                break;
            case SKPaymentTransactionStateRestored:
                 [self restoreTransaction:transaction];
                NSLog(@"交易恢复");
                break;
            default:
                break;
        }
    }
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    NSLog([NSString stringWithFormat:@"交易编号：%d",transaction.error.code]);
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    } else {
        NSLog(@"用户取消交易");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction{
    NSString *product = transaction.payment.productIdentifier;
    if([product length]>0){
        NSArray *tt=[product componentsSeparatedByString:@"."];
        NSString *bookid=[tt lastObject];
        if(bookid){
            
            
        }
    }
}

-(void)requestDidFinish:(SKRequest *)request{
    NSLog(@"反馈信息结束");
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (IBAction)pay:(id)sender {
    [self buy:0];
}

@end
