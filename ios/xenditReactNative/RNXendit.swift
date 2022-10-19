//
//  RNXendit.swift
//  xenditReactNative
//
//  Created by Andy on 19/10/22.
//

import Foundation
import Xendit

@objc(RNXendit)
class RNXendit: NSObject {

  @objc(createSingleUseToken:withPublicKey:withCardNumber:withCardExpMonth:withCardExpYear:withCardCvn:withTransactionAmount:withShouldAuthenticate:withResolver:withRejecter:)
  func createSingleUseToken(
    viewController: UIViewController,
    publicKey: String,
    cardNumber: String,
    cardExpMonth: String,
    cardExpYear: String,
    cardCvn: String,
    transactionAmount: Float,
    shouldAuthenticate: Bool,
    resolve: @escaping RCTPromiseResolveBlock,
    reject: @escaping RCTPromiseRejectBlock) -> Void {

    let cardData = XenditCardData(
      cardNumber: cardNumber,
      cardExpMonth: cardExpMonth,
      cardExpYear: cardExpYear)
    cardData.cardCvn = cardCvn

    let tokenizationRequest = XenditTokenizationRequest(
      cardData: cardData,
      isSingleUse: true,
      shouldAuthenticate: shouldAuthenticate,
      amount: NSNumber(value: transactionAmount),
      currency: "IDR")

    Xendit.publishableKey = publicKey

    let encoder = JSONEncoder()
    let errorResult:NSMutableDictionary = NSMutableDictionary()

    Xendit.createToken(
      fromViewController: viewController,
      tokenizationRequest: tokenizationRequest,
      onBehalfOf: nil) {

        (token, error) in

        if (error != nil ) {
          // Handle error. Error is of type XenditError
          errorResult.setValue(error!.errorCode, forKey: "errorCode")
          errorResult.setValue(error!.message, forKey: "message")
          reject(error!.errorCode, error!.message, nil)
        } else {
          encoder.outputFormatting = .prettyPrinted
          encoder.keyEncodingStrategy = .convertToSnakeCase
          let successJsonData = try? encoder.encode(token);
          let sucessJsonString = String(data: successJsonData!, encoding: .utf8)
          resolve(sucessJsonString!)
        }
    }
  }
}
