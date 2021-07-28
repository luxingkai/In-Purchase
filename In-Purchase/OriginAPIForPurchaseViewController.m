


//
//  OriginAPIForPurchaseViewController.m
//  In-Purchase
//
//  Created by tigerfly on 2021/6/9.
//  Copyright © 2021 tigerfly. All rights reserved.
//

#import "OriginAPIForPurchaseViewController.h"

@interface OriginAPIForPurchaseViewController ()

@end

@implementation OriginAPIForPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     Offer users additional content and services using the original
     In-App Purchase API.
     
     In-App Purchase allows you to offer users the opportunity to purchase
     in-app content and features. Customers can make the purchases within your
     app, or directly from the App Store. For information about promoting your
     products in the App Store, see Promoting Your In-App Purchases.
     
     The StoreKit framework connects to the App Store on your app’s behalf to
     prompt for and securely process payments. The framework then notifies your
     app, which delivers the purchased products. To validate purchases, you
     can verify receipts on your server with the App Store or on the device.
     For auto-renewable subscriptions, the App Store can also notify your
     server of key subscription events.
     */
    
    /**
     Configure In-App Purchases in App Store Connect
     
     To use In-App Purchase, you must first configure the products in
     App Store Connect. As you develop your app, you can add or remove
     products and refine or reconfigure existing products. For more
     information, see Workflow for configuring in-app purchases.
     */
    
    BOOL payment = [SKPaymentQueue canMakePayments];
    
    
    /**
     Understand Product Types
     
     There are four in-App Purchase types you can offer:
     
     •  Consumables are a type that are depleted after one use. Customers can
     purchase them multiple times.
     •  Non-consumables are a type that customers purchase once. They don't expire.
     •  Auto-renewable subscriptions to services or content are a type that
     customers purchase once and that renew automatically on a recurring basis
     until customers decide to cancel.
     •  Non-renewing subscriptions to services or content provide access over a
     limited duration and don't renew automatically. Customers can purchase them again.
     
     You can sync and restore non-consumables and auto-renewable subscriptions
     across devices using StoreKit. When a user purchases an auto-renewable or
     non-renewing subscription, your app is responsible for making it available
     across all the user's devices, and for enabling users to restore past purchases.
     */
    
    
#pragma mark -- Essentails
    
    /*
     Setting Up the Transaction Observer for the Payment Queue
     
     Enable your app to receive and handle transications by adding an observer.
     
     To process transactions in your app, you must create and add an
     observer to the payment queue. The observer object responds to new
     transactions and synchronizes the queue of pending transactions with
     the App Store, and the payment queue prompts the user to authorize
     payment. Your app should add the transaction observer at app launch to
     ensure that your app will receive payment queue notifications as soon
     as possible.
     
     Create an Observer
     Create and build out a custom observer class to handle changes to the payment queue:
     ============================================================
     class StoreObserver: NSObject, SKPaymentTransactionObserver {
     ....
     //Initialize the store observer.
     override init() {
     super.init()
     //Other initialization here.
     }
     
     //Observe transaction updates.
     func paymentQueue(_ queue: SKPaymentQueue,updatedTransactions transactions: [SKPaymentTransaction]) {
     //Handle transaction states here.
     }
     ....
     }
     ============================================================
     
     Create an instance of this observer class to act as the observer of
     changes to the payment queue:
     ============================================================
     let iapObserver = StoreObserver()
     ============================================================
     
     ⚠️ Consider creating your observer as a shared instance of the class
     for global reference in any other class. A shared instance also
     guarantees the lifetime of the object, ensuring callbacks via the
     SKPaymentTransactionObserver protocol are always handled by the same
     instance.
     
     Once you've created the transaction observer, you can add it to the
     payment queue.
     
     
     Add an Observer
     StoreKit attaches your observer to the queue when your app calls:
     ============================================================
     SKPaymentQueue.default().add(iapObserver)
     ============================================================
     
     StoreKit can notify your SKPaymentTransactionObserver instance
     automatically when the content of the payment queue changes upon
     resuming or while running your app.
     
     Implement the transaction observer:
     ============================================================
     import UIKit
     import StoreKit
     
     class AppDelegate: UIResponder, UIApplicationDelegate {
     ....
     // Attach an observer to the payment queue.
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     SKPaymentQueue.default().add(iapObserver)
     return true
     }
     
     // Called when the application is about to terminate.
     func applicationWillTerminate(_ application: UIApplication) {
     // Remove the observer.
     SKPaymentQueue.default().remove(iapObserver)
     }
     ....
     }
     ============================================================
     
     It is important to add the observer at launch, in
     application(_:didFinishLaunchingWithOptions:), to ensure that it
     persists during all launches of your app, receives all payment
     queue notifications, and continues transactions that may be
     processed outside the app, such as:
     
     •  Promoted in-app purchases
     •  Background subscription renewals
     •  Interrupted purchases
     
     The observer must be persistent so it is not deallocated when the
     app is sent to the background. Only a persistent observer can receive
     transactions that may occur while your app is in the background, such
     as a renewal transaction for an auto-renewable subscription.
     */
    
    /**
     SKPaymentQueue
     
     A queue of payment transactions to be processed by the App Store.
     */
    
    /**
     SKPaymentTransactionObserver
     
     A set of methods that process transactions, unlock purchased functionality,
     and continue promoted in-app purchases.
     */
    
    /**
     SKPaymentQueueDelegate
     
     The protocol implemented to provide information needed to complete transactions.
     */
    
    /**
     SKRequest
     
     An abstract class that represents a request to the App Store.
     */
    
    
    
#pragma mark -- Product Information
    
    /*
     Loading In-App Product Identifiers
     
     Load the unique identifiers for your in-app products in order to
     retrieve product information from the App Store.
     
     Implementing an in-app purchase flow can be divided into three stages.
     In the first stage of the purchase process, your app retrieves information
     about its products from the App Store, presents its store UI to the user,
     and lets the user select products. Your app requests payment when the user
     selects a product in your app's store, and finally, your app delivers the
     product. The steps performed by your app and the App Store in the first
     stage are highlighted in Figure 1.
     
     To begin the purchase process, your app must know its product identifiers
     so it can retrieve information about the products from the App Store and
     present its store UI to the user. Every product sold in your app has a
     unique product identifier. You provide this value in App Store Connect
     when you create a new in-app purchase product (see Create an In-App
     Purchase for more information). Your app uses these product identifiers
     to fetch information about products available for sale in the App Store,
     such as pricing, and to submit payment requests when users purchase those
     products.
     
     There are several strategies for storing a list of product identifiers
     in your app, such as embedding in the app bundle or storing on your
     server. You can then retrieve the product identifiers by reading them
     locally in the app bundle or fetching them from your server. Choose the
     method that best serves your app's needs.
     
     ⚠️
     There is no runtime mechanism to fetch a list of all products configured
     in App Store Connect for a particular app. You are responsible for
     managing your app’s list of products and providing that information
     to your app. If you need to manage a large number of products,
     consider using the bulk XML upload/download feature in App Store Connect.
     */
    
    /**
     Retrieve Product IDs from the App Bundle
     
     Embed the product identifiers in your app bundle if:
     
     •  Your app has a fixed list of in-app purchase products. For example, apps
     with an in-app purchase to remove ads or unlock functionality can embed
     the product identifier list in the app bundle.
     
     •  You expect users to update the app in order to see new in-app
     purchase products.
     •  The app or product does not require a server.
     
     Include a property list file in your app bundle containing an array of
     product identifiers, such as the following:
     =========================================================
     <?xml version="1.0" encoding="UTF-8"?>
     <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
     "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
     <plist version="1.0">
     <array>
     <string>com.example.level1</string>
     <string>com.example.level2</string>
     <string>com.example.rocket_car</string>
     </array>
     </plist>
     =========================================================
     
     =========================================================
     guard let url = Bundle.main.url(forResource: "product_ids", withExtension: "plist") else { fatalError("Unable to resolve url for in the bundle.") }
     do {
     let data = try Data(contentsOf: url)
     let productIdentifiers = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as? [String]
     } catch let error as NSError {
     print("\(error.localizedDescription)")
     }
     =========================================================
     */
    
    
    /**
     Retrieve Product IDs from Your Server
     
     Store the product identifiers from your server if:
     
     •  You update the list of in-app products frequently, without updating your app.
     For example, games that supports additional levels or characters should
     fetch the product identifiers list from your server.
     •  The products consist of delivered content.
     •  Your app or product requires a server.
     
     Host a JSON file on your server with the product identifiers. For example,
     the following JSON file contains three product IDs:
     =========================================================
     [
     "com.example.level1",
     "com.example.level2",
     "com.example.rocket_car"
     ]
     =========================================================
     =========================================================
     
     func fetchProductIdentifiers(from url: URL) {
     DispatchQueue.global(qos: .default).async {
     do {
     let jsonData = try Data(contentsOf: url)
     let identifiers = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String]
     
     guard let productIdentifiers = identifiers else {fatalError("Identifiers are not of type String.")}
     
     DispatchQueue.main.async {
     self.delegate?.display(products: productIdentifiers)
     }
     
     } catch let error as NSError {
     print("\(error.localizedDescription)")
     }
     }
     }
     =========================================================
     
     Consider versioning the JSON file so that future versions of your app can
     change its structure without breaking older versions of your app. For
     example, you could name the file that uses the old structure products_v1.json
     and the file that uses a new structure products_v2.json. This is especially
     useful if your JSON file is more complex than the simple array in the example.
     
     To ensure that your app remains responsive, use a background thread to download
     the JSON file and extract the list of product identifiers. To minimize the
     data transferred, use standard HTTP caching mechanisms, such as the
     Last-Modified and If-Modified-Since headers.
     */
    
    
    /*
     Fetching Product Information from the App Store
     
     Retrieve up-to-date information about the products for sale in your app to
     display to the user.
     
     To make sure your users see only products that are actually available for
     them to purchase, query the App Store before displaying your app’s store UI.
     You will need a list of all of your app's product identifiers; for more on
     retrieving this list, see Loading In-App Product Identifiers.
     */
    
    /**
     Request Product Information
     
     To query the App Store, create a products request (SKProductsRequest)
     and initialize it with a list of your product identifiers. Be sure to
     keep a strong reference to the request object; otherwise, the system
     might deallocate the request before it can complete.
     
     The products request retrieves information about valid products,
     along with a list of the invalid product identifiers, and then calls
     its delegate to process the result. The delegate must implement the
     SKProductsRequestDelegate protocol to handle the response from the
     App Store. Here's a simple implementation of both pieces of code:
     ============================================================
     // Keep a strong reference to the product request.
     var request: SKProductsRequest!
     
     func validate(productIdentifiers: [String]) {
     let productIdentifiers = Set(productIdentifiers)
     
     request = SKProductsRequest(productIdentifiers: productIdentifiers)
     request.delegate = self
     request.start()
     }
     
     var products = [SKProduct]()
     // SKProductsRequestDelegate protocol method.
     func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
     if !response.products.isEmpty {
     products = response.products
     // Custom method.
     displayStore(products)
     }
     
     for invalidIdentifier in response.invalidProductIdentifiers {
     // Handle any invalid product identifiers as appropriate.
     }
     }
     ============================================================
     
     Keep a reference to the array of product objects (SKProduct) returned
     to the delegate since you will need the corresponding product object
     to create a payment request when the user purchases a product. If the
     list of products sold on your app is subject to change, such as when
     you add or remove a product from sale, consider creating a custom
     class that encapsulates a reference to the product object along
     with other information, such as pictures or description text that
     you fetch from your server.
     */
    
    /**
     Troubleshoot Invalid Product IDs
     
     Invalid product IDs in the App Store response to your products request
     usually indicate an error in your app’s list of product IDs. Invalid
     product IDs could also mean you configured the product improperly in
     App Store Connect. Actionable UI and insightful logging can help you
     resolve this type of issue more easily:
     
     •  In production builds, fail gracefully by displaying the rest of your app’s
     store UI and omitting the invalid product.
     
     •  In development builds, display an error to call attention to the issue.
     
     •  In both production and development builds, use NSLog to write a message
     to the console so you have a record of the invalid identifier.
     
     •  If your app fetched the list from your server, you could also define a
     logging mechanism to let your app send the list of invalid identifiers
     back to your server.
     */
    
    /**
     SKProductsRequest
     
     An object that can retrieve localized information from the App Store about
     a specified list of products.
     */
    
    /**
     SKProductsResponse
     
     An App Store response to a request for information about a list of products.
     */
    
    /**
     SKProduct
     
     Information about a product previously registered in App Store Connect.
     */
    
    
    
#pragma mark -- Storefront
    
    /*
     SKStorefront
     
     An object containing the location and unique identifier of an Apple App
     Store storefront.
     
     In-app products you create through App Store Connect are available for
     sale in every region with an App Store. You can use the storefront information
     to determine the customer's region, and offer in-app products suitable for
     that region. StoreKit exposes SKStorefront storefront information as a
     read-only property in SKPaymentQueue.
     
     You must maintain your own list of product identifiers and the storefronts
     in which you want to make them available.
     
     ⚠️
     Don't save the storefront information with your user information;
     storefront information can change at any time. Always get the storefront
     identifier immediately before you display product information or
     availability to the user in your app. Storefront information may not be
     used to develop or enhance a user profile, or track customers for
     advertising or marketing purposes.
     */
    
    /**
     Show Products Based on the Current Storefront
     
     The following example function shouldShow returns false if your product
     is not suitable for the given storefront. You must create your own list
     of products available by storefront, referred to as myProducts in
     Listing 1.
     ========================================================
     func shouldShow(_ productIdentifier: String, in storefront: SKStorefront) -> Bool {
     var shouldShow = true
     
     // myProducts is a dictionary representing your own metadata for products,
     // keyed on an SKProduct.productIdentifier.
     if let myProduct = myProducts[productIdentifier] {
     shouldShow = myProduct.countryCodes.contains(storefront.countryCode)
     }
     return shouldShow
     }
     ==-=====================================================
     
     Listing 2 requests information for products that you wish to display based on
     the device's storefront.
     ========================================================
     func fetchProductInfo() {
     var identifiers = Set<String>()
     if let storefront = SKPaymentQueue.default().storefront {
     for (identifier, _) in myProducts {
     if shouldShow(identifier, in: storefront) {
     identifiers.insert(identifier)
     }
     }
     let request = SKProductsRequest(productIdentifiers: identifiers)
     request.delegate = self
     request.start()
     }
     }
     ========================================================
     */
    
    /**
     Listen for Storefront Changes
     
     The storefront value can change at any time. To listen for changes
     in this value, implement the paymentQueueDidChangeStorefront(_:) method.
     Refresh the list of your available products when the storefront changes,
     as shown in Listing 3.
     ========================================================
     func paymentQueueDidChangeStorefront(_ queue: SKPaymentQueue) {
     if let storefront = queue.storefront {
     // Refresh the displayed products based on the new storefront.
     for product in storeProducts {
     if shouldShow(product.productIdentifier, in: storefront) {
     // Display this product in your store UI.
     }
     }
     }
     }
     ========================================================
     */
    
    /**
     Respond to Storefront Changes
     
     The current storefront can change at any time, including during a
     transaction. Listing 4 determines whether the transaction should
     continue in the updated storefront. Your delegate's
     paymentQueue(_:shouldContinue:in:) method must return quickly,
     before the call times out.
     
     Listing 4 Determine whether to continue a transaction in an updated storefront
     ========================================================
     SKPaymentQueue.default().delegate = self  // Set your object as the SKPaymentQueue delegate.
     
     func paymentQueue(_ paymentQueue: SKPaymentQueue,
     shouldContinue transaction: SKPaymentTransaction,
     in newStorefront: SKStorefront) -> Bool {
     return shouldShow(transaction.payment.productIdentifier, in: newStorefront)
     }
     ========================================================
     
     If the product isn't available in the updated storefront,
     the transaction fails with the error SKError.Code.storeProductNotAvailable.
     Handle this error in your paymentQueue(_:updatedTransactions:) method
     by displaying an alert to let the user know why the app can't
     complete the transaction.
     
     ========================================================
     Listing 5 Display an alert if a product is not available in an updated storefront
     func paymentQueue(_ queue: SKPaymentQueue,
     updatedTransactions transactions: [SKPaymentTransaction]) {
     for transaction in transactions {
     if let transactionError = transaction.error as NSError?,
     transactionError.domain == SKErrorDomain
     && transactionError.code == SKError.storeProductNotAvailable.rawValue {
     // Show an alert.
     }
     }
     }
     ========================================================
     */
    
    
#pragma mark -- Purchases
    
    /*
     Requesting a Payment from the App Store
     
     Submit a payment request to the App Store when a user selects a product to buy.
     
     After you present your app's store UI, users can make purchases
     from within your app. When the user chooses a product, your app
     creates and submits a payment request to the App Store.
     
     Implementing an in-app purchase flow can be divided into three stages.
     In the first stage, your app retrieves product information. Then your
     app requests payment when the user selects a product in your app's
     store. Finally, your app delivers the products. This article details
     the steps performed by your app and the App Store in the second
     stage, as highlighted in Figure 1.
     */
    
    /**
     Create a Payment Request
     
     When the user selects a product to buy, create a payment request using
     the corresponding SKProduct object and set the quantity if needed,
     as shown below. The product object comes from the array of products
     returned by your app’s products request, as discussed in Fetching
     Product Information from the App Store.
     ========================================================
     // Use the corresponding SKProduct object returned in the array from SKProductsRequest.
     let payment = SKMutablePayment(product: product)
     payment.quantity = 2
     ========================================================
     */
    
    /**
     Submit a Payment Request
     
     Submit your payment request to the App Store by adding it to the payment queue. If you add a payment object to the queue more than once, it's submitted to the App Store multiple times, charging the user and requiring your app to deliver the product each time.
     ========================================================
     SKPaymentQueue.default().add(payment)
     ========================================================
     
     For every payment request your app submits, it receives a corresponding
     transaction to process. For more information about transactions and the
     payment queue, see Processing a Transaction.
     
     For auto-renewable subscriptions, you may submit a payment request with
     a subscription offer for users you determine eligible to receive an offer.
     */
    
    
    /*
     Processing a Transaction
     
     Register a transaction queue observer to get and handle transaction
     updates from the App Store.
     
     Implementing an in-app purchase flow can be divided into three stages.
     You first retrieve the product information, then send a payment request
     by adding it to the payment queue. Finally, your app delivers the
     products for successful transactions. This article details the steps
     performed by your app and the App Store in the last stage, as highlighted
     in Figure 1.
     
     The App Store calls the transaction queue observer after it processes the
     payment request. Your app then records information about the purchase
     for future launches, downloads the purchased content, and marks the
     transaction as finished.
     */
    
    /**
     Monitor Transactions in the Queue
     
     The transaction queue plays a central role in letting your app
     communicate with the App Store through the StoreKit framework.
     You add work to the queue that the App Store needs to act on,
     such as a payment request to be processed. When the transaction’s
     state changes, such as when a payment request succeeds, StoreKit
     calls the app’s transaction queue observer. You decide which
     class acts as the observer. In very small apps, you could handle
     all the StoreKit logic in the app delegate, including observing
     the transaction queue. In most apps, however, you create a separate
     class that handles this observer logic along with the rest of your
     app’s store logic. The observer must conform to the
     SKPaymentTransactionObserver protocol.
     
     By adding an observer, your app does not need to constantly
     poll the status of its active transactions. Your app uses the
     transaction queue for payment requests, to download Apple-hosted
     content, and to find out that subscriptions have been renewed.
     
     Always register a transaction queue observer as soon as your app
     is launched, as shown below.
     ========================================================
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     SKPaymentQueue.default().add(observer)
     return true
     }
     ========================================================
     
     Make sure that the observer is ready to handle a transaction at
     any time, not only after you add a transaction to the queue.
     For example, if a user buys something in your app right before
     going into a tunnel, your app may not be able to deliver the
     purchased content if there is no network connection. The next time
     your app launches, StoreKit calls your transaction queue observer
     again and your app should handle the transaction and deliver the
     purchased content. Similarly, if your app fails to mark a transaction
     as finished, StoreKit calls the observer every time your app
     launches until the transaction finishes.
     
     Implement the paymentQueue(_:updatedTransactions:) method on your
     transaction queue observer. StoreKit calls this method when the status
     of a transaction changes, such as when a payment request has been
     processed. The transaction status tells you what action your app
     needs to perform, as described in Table 1.
     
     Transactions in the queue can change state in any order. Your app needs
     to be ready to work on any active transaction at any time. Act on every
     transaction according to its transaction state, as in this example:
     ========================================================
     func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
     for transaction in transactions {
     switch transaction.transactionState {
     // Call the appropriate custom method for the transaction state.
     case .purchasing: showTransactionAsInProgress(transaction, deferred: false)
     case .deferred: showTransactionAsInProgress(transaction, deferred: true)
     case .failed: failedTransaction(transaction)
     case .purchased: completeTransaction(transaction)
     case .restored: restoreTransaction(transaction)
     // For debugging purposes.
     @unknown default: print("Unexpected transaction state \(transaction.transactionState)")
     }
     }
     }
     ========================================================
     */
    
    /**
     Update the App's UI to Reflect Transaction Changes
     
     To keep your user interface up to date while waiting, the transaction
     queue observer can implement optional methods from the
     SKPaymentTransactionObserver protocol as follows:
     
     •  StoreKit calls the paymentQueue(_:removedTransactions:) method
     when it removes transactions from the queue. In your implementation
     of this method, remove the corresponding items from your app’s UI.
     •  StoreKit calls the paymentQueueRestoreCompletedTransactionsFinished(_:) or  paymentQueue(_:restoreCompletedTransactionsFailedWithError:) methods when it
     finishes restoring transactions, depending on whether there was an error.
     In your implementation of these methods, update your app’s UI to reflect
     the success or failure.
     
     For successfully processed transactions, your app should validate the receipt
     associated with the transaction to verify the items purchased by the user and
     unlock content accordingly. For more information on validating receipts
     server-side, see Validating Receipts with the App Store.
     */
    
    /**
     SKPayment
     
     A request to the App Store to process payment for additional functionality
     offered by your app.
     */
    
    /**
     SKMutablePayment
     
     A mutable request to the App Store to process payment for additional
     functionality offered by your app.
     */
    
    /**
     SKPaymentTransaction
     
     An object in the payment queue.
     */
    
    
    
#pragma mark -- Purchase Validation
    
    /*
     Choosing a Receipt Validation Technique
     
     Select the type of receipt validation that works for your app.
     
     An App Store receipt provides a record of the sale of an app or any
     purchase made from within the app, and you can authenticate purchased
     content by adding receipt validation code to your app or server.
     Receipt validation requires an understanding of secure coding techniques
     in order to employ a solution that is secure and unique to your
     application.
     */
    
    /**
     Choose a Validation Technique
     
     There are two ways to verify a receipt's authenticity:
     
     •  Local, on-device receipt validation, recommended to validate the
     signature of the receipt for apps with in-app purchases.
     •  Server-side receipt validation with the App Store, recommended for
     persisting in-app purchases to maintain and manage purchase records.
     
     Compare the approaches and determine the best fit for your app and your
     infrastructure. You can also choose to implement both approaches.
     
     Consumable in-app purchases remain in the receipt until you call
     finishTransaction(_:). Maintain and manage records of consumables on
     a server if needed. Non-consumables, auto-renewing subscription items,
     and non-renewing subscription items remain in the receipt indefinitely.
     For auto-renewable subscription management, server-side receipt
     validation gives key advantages over on-device receipt validation.
     
     file:///Users/tigerfly/Desktop/In-Purchase/In-Purchase/on-device_auto-renewable_subscriptions.png
     
     ⚠️ In order for on-device receipt validation to include renewal transactions,
     there must be an internet connection to refresh the receipt.
     */
    
    /**
     Verify Receipts
     
     Validating locally requires code to read and validate a PKCS #7 signature,
     and code to parse and validate the signed payload. Validating with the
     App Store requires a secure connection between your app and your server,
     and code on your server to to validate the receipt with the App Store.
     For more information on server-side validation, see Validating Receipts
     with the App Store.
     
     Although receipts typically update immediately after a completed purchase
     or restored purchase, changes can happen at other times when the app is
     not running. When necessary, call SKReceiptRefreshRequest to ensure the
     receipt you are working with is up-to-date, such as when a subscription
     renews in the background. This refresh requires a network connection.
     */
    
    NSURL *url = [[NSBundle mainBundle] appStoreReceiptURL];
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:url.path];
    if (result) {
        NSData *receiptData = [NSData dataWithContentsOfURL:url];
        NSLog(@"%@",receiptData);
    }
    
    
    /*
     Validating Receipts with the App Store
     
     Verify transactions with the App Store on a secure server.
     
     An App Store receipt is a binary encrypted file signed with an Apple
     certificate. In order to read the contents of the encrypted file,
     you need to pass it through the verifyReceipt endpoint. The endpoint's
     response includes a readable JSON body. Communication with the App
     Store is structured as JSON dictionaries, as defined in RFC 4627.
     Binary data is Base64-encoded, as defined in RFC 4648. Validate
     receipts with the App Store through a secure server.
     
     ⚠️ Do not call the App Store server verifyReceipt endpoint from
     your app. You can't build a trusted connection between a user’s
     device and the App Store directly, because you don’t control either
     end of that connection, which makes it susceptible to a
     machine-in-the-middle attack.
     */
    
    /**
     Fetch the Receipt Data

     To retrieve the receipt data from the app on the device, use the
     appStoreReceiptURL method of NSBundle to locate the app’s receipt,
     and encode the data in Base64. Send this Base64-encoded data to your server.
     ========================================================
     // Get the receipt if it's available
     if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
         FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

         do {
             let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
             print(receiptData)

             let receiptString = receiptData.base64EncodedString(options: [])

             // Read receiptData
         }
         catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
     }
     ========================================================
     */
    
    /**
     Send the Receipt Data to the App Store

     On your server, create a JSON object with the receipt-data, password
     (if the receipt contains an auto-renewable subscription), and
     exclude-old-transactions keys detailed in requestBody.
     
     Submit this JSON object as the payload of an HTTP POST request. Use the
     test environment URL https://sandbox.itunes.apple.com/verifyReceipt when
     testing your app in the sandbox and while your application is in review.
     Use the production URL https://buy.itunes.apple.com/verifyReceipt when
     your app is live in the App Store.
     
     ⚠️ Verify your receipt first with the production URL; then verify with
     the sandbox URL if you receive a 21007 status code. This approach
     ensures you do not have to switch between URLs while your application
     is tested, reviewed by App Review, or live in the App Store.
     */
    
    /**
     Parse the Response
     
     The App Store's response payload is a JSON object that contains the
     keys and values detailed in responseBody.
     
     The in_app array contains the non-consumable, non-renewing subscription,
     and auto-renewable subscription items previously purchased by the user.
     Check the values in the response for these in-app purchase types to
     verify transactions as needed.
     
     For auto-renewable subscription items, parse the response to get
     information about the currently active subscription period. When you
     validate the receipt for a subscription, latest_receipt contains
     the latest encoded receipt, which is the same as the value for
     receipt-data in the request, and latest_receipt_info contains all the
     transactions for the subscription, including the initial purchase and
     subsequent renewals but not including any restores.
     
     You can use these values to check whether an auto-renewable subscription
     has expired. Use these values along with the expiration_intent
     subscription field to get the reason for expiration.
     */
    
    /**
     SKReceiptRefreshRequest
     
     A request to refresh the receipt, which represents the user's transactions
     with your app.
     */
    
    
#pragma mark -- Content Delivery

    
#pragma mark -- Refunds
    
    /*
     Handling Refund Notifications
     
     Respond to notifications created during customer refunds for consumable,
     non-consumable, and non-renewing subscription products.
     
     App Store Server sends near real-time notifications when customers
     receive refunds for in-app purchases. If you offer content across
     multiple platforms, for example gems or coins for games, and you update
     player account balances on your server, receiving refund notifications
     is important. Respond to refund notifications by interpreting and
     handling the refund information, and informing customers in the app
     of any actions you take as a result of the refund.
     */
    
    
    
#pragma mark -- Providing Access to Previously Purchased Products

    /*
     Restoring Purchased Products

     Users sometimes need to restore purchased content, such as when
     they upgrade to a new phone. Include some mechanism in your app,
     such as a Restore Purchases button, to let them restore their
     purchases.

     ⚠️
     Don't automatically restore purchases, especially when your app is
     launched. Restoring purchases prompts for the user’s App Store
     credentials, which interrupts the flow of your app.

     In most cases, you only need to refresh the app receipt and deliver
     the products listed on the receipt. The refreshed receipt contains
     a record of the user’s purchases in this app, from any device the
     user's App Store account is logged into. However, an app might
     require an alternative approach under the given circumstances:
     
     •  You use Apple-hosted content — Restore completed transactions to
     give your app the transaction objects it uses to download the content.
     •  You need to support your app on devices where the app receipt isn’t
     available — Restore completed transactions instead.
     •  Your app uses non-renewing subscriptions — Your app is responsible
     for the restoration process.
     
     Refreshing a receipt doesn't create new transactions; it requests the
     latest copy of the receipt from the App Store. Refresh the receipt only
     once; refreshing multiple times in a row has the same result.
     
     Restoring completed transactions creates a new transaction for every
     transaction previously completed, essentially replaying history for your
     transaction queue observer. Your app maintains its own state to keep
     track of why it’s restoring completed transactions and how to handle
     them. Restoring multiple times creates multiple restored transactions
     for each completed transaction.

     ⚠️
     If the user attempts to purchase a product that they've already purchased,
     the App Store creates a regular transaction instead of a restore transaction,
     but the user isn’t charged again for the product. Unlock the content for
     these transactions the same way you would for original transactions.
     
     Give the user an appropriate level of control over the content that's
     downloaded again. For example, don't automatically download three
     years of daily newspapers or hundreds of megabytes of game levels
     at the same time.
     */
    
    /**
     Refresh the App Receipt

     Create a receipt refresh request, set a delegate, and start the
     request. The request supports optional properties for obtaining
     receipts in various states, such as expired receipts, during testing.
     For details, see the init(receiptProperties:) method of
     SKReceiptRefreshRequest.
     ===================================================
     let refresh = SKReceiptRefreshRequest()
     refresh.delegate = self
     refresh.start()
     ===================================================

     After the app receipt is refreshed, examine it and deliver any
     products that were added to the receipt.
     */
    
    /**
     Restore Completed Transactions

     Your app starts restoring completed transactions by calling the
     restoreCompletedTransactions() method of SKPaymentQueue. This
     call sends a request to the App Store to restore all of your app’s
     completed transactions. If your app sets a value for the
     applicationUsername property of its payment requests, use the restoreCompletedTransactions(withApplicationUsername:) method to
     provide the same information when restoring the transactions.
     
     The App Store generates a new transaction to restore each previously
     completed transaction. The restored transaction refers to the
     original transaction: Instances of SKPaymentTransaction have an
     originalTransaction property, and the entries in the receipt have
     an original_transaction_id field value.
     
     ⚠️ The date fields have slightly different meanings for restored
     purchases. For details, see the purchase_date and original_purchase_date
     fields in the responseBody.Receipt.In_app.
     
     StoreKit calls the transaction queue observer with a status of
     SKPaymentTransactionState.restored for each restored transaction,
     as described in Processing a Transaction. The action you take at
     this point depends on your app's design.
     
     If your app uses the app receipt and doesn't have Apple-hosted content,
     this code isn't needed because your app doesn’t restore completed
     transactions. Finish any restored transactions immediately.
     
     If your app uses the app receipt and has Apple-hosted content, let the
     user select which products to restore before starting the restoration
     process. During restoration, download the user-selected content
     before finishing those transactions, and finish any other transactions
     immediately.
     ======================================================
     let productIDsToRestore: [String]() = <# From the user #>
     let transaction: SKPaymentTransaction = <# Current transaction #>

     guard let identifier = transaction.transactionIdentifier else { customError() }
     if productIDsToRestore.contains(identifier) {
     // Re-download the Apple-hosted content
     }

     SKPaymentQueue.default().finishTransaction(transaction)
     ======================================================
     
     If your app doesn't use the app receipt, it examines all completed
     transactions as they're restored. It uses a similar code path to
     the original purchase logic to make the product available and then
     finishes the transaction. Apps with more than a few products,
     especially products with associated content, let the user select
     which products to restore instead of restoring everything. These
     apps keep track of which completed transactions to process as
     they're restored, and which transactions to ignore by finishing
     them immediately without restoring them.
     */
    
    
    /**
     SKReceiptRefreshRequest
     
     A request to refresh the receipt, which represents the user's
     transactions with your app.
     */
    
    /**
     SKRequest

     An abstract class that represents a request to the App Store.
     */

    /**
     SKPaymentTransaction
     
     An object in the payment queue.
     */

    
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
