//
//  RNXenditModule.m
//  xenditReactNative
//
//  Created by Andy on 19/10/22.
//

#import <Foundation/Foundation.h>

#import <React/RCTLog.h>

#import <xenditReactNative-Swift.h>

#import "RNXenditModule.h"

@implementation RNXenditModule : NSObject

RCT_EXPORT_MODULE(RNXenditModule);

RCT_EXPORT_METHOD(createSingleUseToken:(NSString *)publicKey
                  withCardNumber:(NSString *)cardNumber
                  withCardExpMonth:(NSString *)cardExpMonth
                  withCardExpYear:(NSString *)cardExpYear
                  withCardCvn:(NSString *)cardCvn
                  withTransactionAmount:(float)transactionAmount
                  withShouldAuthenticate:(BOOL)shouldAuthenticate
                  withResolver:(RCTPromiseResolveBlock)resolve
                  withRejecter:(RCTPromiseRejectBlock)reject) {

  RCTLogInfo(@"Pretending to create single use token %@ , %@/%@", cardNumber, cardExpMonth, cardExpYear);

  UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;

  RNXendit *xendit = [RNXendit alloc];

  [xendit createSingleUseToken:rootViewController
                   withPublicKey:publicKey
                  withCardNumber:cardNumber
                withCardExpMonth:cardExpMonth
                 withCardExpYear:cardExpYear
                     withCardCvn:cardCvn
           withTransactionAmount:transactionAmount
          withShouldAuthenticate:shouldAuthenticate
                    withResolver:resolve
                    withRejecter:reject];

}

@end
