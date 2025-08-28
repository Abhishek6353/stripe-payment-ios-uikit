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
                self.showAlert(
                    title: "🌟 Thank You!",
                    message: "Your generous donation helps us continue our mission. We truly appreciate your support 🙏"
                )
                
            case .canceled:
                print("❌ Payment canceled")
                self.showAlert(
                    title: "Payment Canceled",
                    message: "You canceled the payment process."
                )
                
            case .failed(let error):
                print("⚠️ Payment failed: \(error.localizedDescription)")
                self.showAlert(
                    title: "Payment Error",
                    message: error.localizedDescription
                )
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
