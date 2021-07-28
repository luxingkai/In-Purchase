

//
//  In-AppPurchaseViewController.m
//  In-Purchase
//
//  Created by tigerfly on 2021/6/9.
//  Copyright © 2021 tigerfly. All rights reserved.
//

#import "In-AppPurchaseViewController.h"

@interface In_AppPurchaseViewController ()

@end

@implementation In_AppPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     Use the latest API to support in-app purchases in your new or existing
     app, or the original API for an existing app.


     The StoreKit framework provides two APIs for implementing a store in your app and offering in-app purchases:
     • In-App Purchase, a Swift-based API that provides Apple-signed transactions in
        JSON Web Signature (JWS) format, available starting in iOS 15, macOS 12, tvOS 15,
        and watchOS 8.
     • Original API for In-App Purchase, an API that provides transaction information
        using App Store receipts, available starting in iOS 3, macOS 10.7, tvOS 9, and
        watchOS 6.2.
     
     Both APIs provide access to your data in the App Store, such as your configured
     in-app purchases and transaction information for your customers. They also provide
     the same user experience with the App Store for your customers. In-app purchases
     that users make using either API are fully available to both APIs.
     */
    
    
    /*
     Use the Original API to Support Certain Features
     
     You may need to use the original in-app purchase API if your app depends on any
     of the following features:
     
     •  To provide support for the Volume Purchase Program (VPP).
        For more information, see Device Management.
     •  To provide app pre-orders. For more information, see Offering Your App for Pre-Order.
     •  Your app changed from a premium to a freemium model, or vice versa.
     
     Use the original API for existing and legacy apps.
     */
    
    
#pragma mark -- In-purchase (available to iOS 15)
     
    
    
#pragma mark -- Origianl API for In-App Purchase
    
    
    
    
    
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
