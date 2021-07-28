//
//  AppDelegate.m
//  In-Purchase
//
//  Created by tigerfly on 2020/5/23.
//  Copyright © 2020 tigerfly. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "OriginAPIForPurchaseViewController.h"

@interface TransactionObserver : NSObject<SKPaymentTransactionObserver>

@end

@implementation TransactionObserver

+ (instancetype)shareInstance {
    static TransactionObserver *transactionObserver = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transactionObserver = [TransactionObserver new];
    });
    return transactionObserver;
}

// Sent when the transaction array has changed (additions or state changes).
// Client should check state of transactions and finish as appropriate.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
}

// Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    
}

// Sent when all transactions from the user's purchase history have successfully been added back to the queue.
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    
}

// Sent when the download state has changed.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray<SKDownload *> *)downloads {
    
}

// Sent when a user initiates an IAP buy from the App Store
- (BOOL)paymentQueue:(SKPaymentQueue *)queue shouldAddStorePayment:(SKPayment *)payment forProduct:(SKProduct *)product {
    return true;
}

- (void)paymentQueueDidChangeStorefront:(SKPaymentQueue *)queue {
    
}

@end


@interface AppDelegate ()
@property (nonatomic, strong) TransactionObserver *transactionObserver;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.transactionObserver = [TransactionObserver shareInstance];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self.transactionObserver];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    OriginAPIForPurchaseViewController *vc = [OriginAPIForPurchaseViewController new];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)applicationWillTerminate:(UIApplication *)application {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self.transactionObserver];
}


@end
