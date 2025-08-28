//
//  ViewController.swift
//  stripe-payment-ios-uikit
//
//  Created by Apple on 28/08/25.
//

import UIKit
import StripePaymentSheet

class ViewController: UIViewController {
    
    var paymentSheet: PaymentSheet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
    }
    
    
    //MARK: - Actions
    @IBAction func btnDonate10Tapped(_ sender: UIButton) {
        createPaymentIntent(amount: 1000) { result in
            switch result {
            case .success(let clientSecret):
                
                DispatchQueue.main.async {
                    self.presentPaymentSheet(clientSecret: clientSecret)
                }
                
            case .failure(let error):
                print("Failed to create payment intent: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func btnDonate20Tapped(_ sender: UIButton) {
        createPaymentIntent(amount: 2000) { result in
            switch result {
            case .success(let clientSecret):
                
                DispatchQueue.main.async {
                    self.presentPaymentSheet(clientSecret: clientSecret)
                }
                
            case .failure(let error):
                print("Failed to create payment intent: \(error.localizedDescription)")
            }
        }
    }
    
    
    private func createPaymentIntent(amount: Int, completion: @escaping (Result<String, Error>) -> Void) {
        
        let param: [String : Any] = [
            "amount": amount,
            "currency": "usd"
        ]
        
        NetworkManager.shared.post(url: "https://stripe-vercel-backend-sepia.vercel.app/api/create-payment-intent", parameters: param) { (result: Result<PaymentIntentResponseModel, Error>) in
            
            
            switch result {
            case .success(let response):
                completion(.success(response.clientSecret))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func presentPaymentSheet(clientSecret: String) {
        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Donation"
        
        paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: configuration)
        
        paymentSheet?.present(from: self) { paymentResult in
            switch paymentResult {
            case .completed:
                print("✅ Payment success")
            case .canceled:
                print("❌ Payment canceled")
            case .failed(let error):
                print("⚠️ Payment failed: \(error)")
            }
        }
    }
}
