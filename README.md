# Stripe Payment iOS (UIKit)

This project demonstrates how to integrate **Stripe payments** in a native iOS app using **UIKit** and a custom backend deployed on **Vercel**.

---

## 🚀 Features
- Native UIKit payment flow  
- Integration with Stripe iOS SDK  
- Secure **PaymentIntent** creation via backend (Vercel + Node.js)  

### Example Flow
1. App requests a `clientSecret` from backend  
2. User enters card details in app  
3. Stripe SDK confirms payment  

---

## 📱 Requirements
- iOS 14.0+  
- Xcode 15+  
- Swift 5.9+  
- CocoaPods or Swift Package Manager  

---

## ⚙️ Setup

### 1. Clone the repository
```bash
git clone https://github.com/Abhishek6353/stripe-payment-ios-uikit.git
cd stripe-payment-ios-uikit
```

### 2. Install dependencies
#### Using Swift Package Manager (recommended):
1. In Xcode, go to **File > Add Packages...**  
2. Add Stripe iOS SDK:  
```bash
https://github.com/stripe/stripe-ios
```

### 3. Configure Backend URL
#### Update your backend endpoint inside the app (replace with your deployed Vercel backend):
```bash
let backendURL = "https://your-vercel-backend.vercel.app"
```

### 4. Run the app
1. Open the project in **Xcode**  
2. Select a **simulator / device**  
3. Run (`⌘R`)  

---

## 🔑 How It Works
1. The app requests a **PaymentIntent** from backend (`/create-payment-intent`)  
2. Backend uses your **Stripe Secret Key** (server-side only) to create the intent  
3. Backend responds with `clientSecret`  
4. The app uses **Stripe SDK** to confirm payment securely  


## 🛡️ Security Notes
- ❌ Never expose your **Stripe Secret Key** in the iOS app  
- ✅ All sensitive operations (like creating a PaymentIntent) should be done in the backend  


## 📚 Resources
- [Stripe iOS SDK Docs](https://stripe.com/docs/payments/accept-a-payment?platform=ios)  
- [Stripe Dashboard](https://dashboard.stripe.com)  
- [Vercel Deployment Guide](https://vercel.com/docs/deployments/overview)  
