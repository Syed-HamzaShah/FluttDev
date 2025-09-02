# 💳 Razorpay Integration - Flutter

A step-by-step Razorpay payment gateway integration in Flutter.
Supports cards, UPI, wallets, and net banking with success, error, and external wallet handling.

## ✨ Features

🔑 Easy Razorpay SDK setup with event listeners

💰 Accept payments in INR (converted to paise)

📱 Supports Cards, UPI, Wallets, Net Banking, EMI

✅ Handles success, error, and external wallet callbacks

🧾 Ready for backend verification & order updates

## 📸 Screenshot (Sample)

![alt text](<secure pay.png>)

## Razorpay integration flow step by step:

````

## 🔄 **Razorpay Payment Flow**

### **1. Initialization Phase**
```dart
@override
void initState() {
  super.initState();

  // Create Razorpay instance
  _razorpay = Razorpay();

  // Register event listeners
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
}
````

**What happens:**

- Creates a Razorpay instance to handle payments
- Registers 3 callback functions for different payment outcomes
- These listeners wait for events from Razorpay SDK

---

### **2. Payment Initiation Flow**

```
User Input → Validation → Razorpay Checkout → Payment Gateway
```

**Step-by-step:**

**A) User enters amount and clicks "Pay Securely"**

```dart
onPressed: () {
  double? amount = double.tryParse(amountController.text);
  if (amount != null && amount > 0) {
    openCheckout(amount); // Start payment process
  }
}
```

**B) Amount validation and conversion**

```dart
void openCheckout(double amount) async {
  // Convert rupees to paise (Razorpay requires paise)
  int amountInPaise = (amount * 100).toInt();
  // ₹100 becomes 10,000 paise
}
```

**C) Payment options configuration**

```dart
var options = {
  'key': 'rzp_test5135135351',        // Your Razorpay API key
  'amount': amountInPaise,            // Amount in paise
  'name': 'SecurePay',               // Business name
  'description': 'Payment for services',
  'prefill': {                       // Pre-filled customer data
    'contact': '1234567890',
    'email': 'user@example.com',
  },
  'theme': {
    'color': '#3F51B5',             // Custom theme color
  },
  'external': {
    'wallets': ['paytm', 'phonepe', 'googlepay'], // Wallet options
  },
};
```

**D) Launch Razorpay checkout**

```dart
_razorpay.open(options); // Opens Razorpay payment interface
```

---

### **3. Razorpay Checkout Interface**

When `_razorpay.open(options)` is called:

```
Your App → Razorpay SDK → Payment Interface → Payment Gateway
```

**What user sees:**

1. **Payment methods screen** with options like:

   - Credit/Debit Cards
   - Net Banking
   - UPI (GPay, PhonePe, Paytm)
   - Wallets
   - EMI options

2. **User selects payment method** and enters details

3. **Payment processing** happens on secure servers

---

### **4. Payment Result Handling**

Based on payment outcome, one of three callbacks is triggered:

#### **🟢 Success Scenario**

```dart
void handlePaymentSuccess(PaymentSuccessResponse response) {
  setState(() {
    _isProcessing = false; // Hide loading state
  });

  // Show success message
  Fluttertoast.showToast(
    msg: "Payment Successful! ID: ${response.paymentId}",
    backgroundColor: Colors.green,
  );

  // Clear form
  amountController.clear();

  // Here you would typically:
  // - Update your database
  // - Send confirmation to your backend
  // - Navigate to success screen
}
```

**Success Response contains:**

- `paymentId`: Unique payment identifier
- `orderId`: Your order reference (if used)
- `signature`: Payment verification signature

#### **🔴 Error Scenario**

```dart
void handlePaymentError(PaymentFailureResponse response) {
  setState(() {
    _isProcessing = false;
  });

  // Show error message
  Fluttertoast.showToast(
    msg: "Payment Failed: ${response.message}",
    backgroundColor: Colors.red,
  );

  // Common error reasons:
  // - Insufficient funds
  // - Network issues
  // - Invalid card details
  // - User cancelled
}
```

#### **🔵 External Wallet Scenario**

```dart
void handleExternalWallet(ExternalWalletResponse response) {
  // When user selects external wallet (PayTM, PhonePe, etc.)
  // This redirects to wallet app
  Fluttertoast.showToast(
    msg: "External Wallet: ${response.walletName}",
    backgroundColor: Colors.blue,
  );
}
```

---

### **5. Complete Flow Diagram**

```
[User enters ₹100]
       ↓
[Validation: ₹100 → 10,000 paise]
       ↓
[Create payment options object]
       ↓
[_razorpay.open(options)]
       ↓
[Razorpay SDK opens payment interface]
       ↓
[User selects payment method & pays]
       ↓
    ┌─────────────────────┐
    │   Payment Gateway   │
    │   Processing...     │
    └─────────────────────┘
       ↓
┌──────────────────────────────────┐
│         Result                   │
├──────────────────────────────────┤
│ ✅ Success → handlePaymentSuccess │
│ ❌ Error   → handlePaymentError   │
│ 💳 Wallet  → handleExternalWallet │
└──────────────────────────────────┘
       ↓
[Update UI, show toast, clear form]
       ↓
[Optional: Update backend, navigate]
```

---

### **6. Important Implementation Details**

#### **Currency Conversion**

```dart
// Razorpay works in paise (smallest currency unit)
amount = amount * 100;  // ₹1 = 100 paise
// So ₹100 becomes 10,000 paise
```

#### **API Keys**

```dart
'key': 'rzp_test5135135351'  // Test key (starts with rzp_test)
// Live key would start with 'rzp_live'
```

#### **Memory Management**

```dart
@override
void dispose() {
  _razorpay.clear();  // Clean up listeners
  super.dispose();
}
```

#### **Error Handling**

```dart
try {
  _razorpay.open(options);
} catch (e) {
  // Handle SDK errors (network, configuration, etc.)
  print(e);
}
```

---

### **7. Backend Integration (Optional)**

For production apps, you'd typically:

```dart
void handlePaymentSuccess(PaymentSuccessResponse response) {
  // 1. Send payment details to your backend
  await sendToBackend({
    'paymentId': response.paymentId,
    'amount': amount,
    'userId': currentUserId,
  });

  // 2. Verify payment signature on backend
  // 3. Update order status
  // 4. Send confirmation email/SMS
}
```

```

```
