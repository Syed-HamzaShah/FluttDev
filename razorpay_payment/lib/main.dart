import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RazorPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3F51B5),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const RazorPayClass(),
    );
  }
}

class RazorPayClass extends StatefulWidget {
  const RazorPayClass({super.key});

  @override
  State<RazorPayClass> createState() => _RazorPayClassState();
}

class _RazorPayClassState extends State<RazorPayClass>
    with TickerProviderStateMixin {
  late Razorpay _razorpay;
  TextEditingController amountController = TextEditingController();

  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations
    _slideController.forward();
    _fadeController.forward();
    _scaleController.forward();

    // Initialize Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openCheckout(double amount) async {
    if (amount <= 0) {
      Fluttertoast.showToast(
        msg: "Please enter a valid amount",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    int amountInPaise = (amount * 100).toInt();

    var options = {
      'key': 'rzp_test5135135351',
      'amount': amountInPaise,
      'name': 'SecurePay',
      'description': 'Payment for services',
      'prefill': {'contact': '1234567890', 'email': 'user@example.com'},
      'theme': {'color': '#3F51B5'},
      'external': {
        'wallets': ['paytm', 'phonepe', 'googlepay'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _isProcessing = false;
    });

    Fluttertoast.showToast(
      msg: "Payment Successful! ID: ${response.paymentId}",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );

    // Clear the amount field
    amountController.clear();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isProcessing = false;
    });

    Fluttertoast.showToast(
      msg: "Payment Failed: ${response.message}",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isProcessing = false;
    });

    Fluttertoast.showToast(
      msg: "External Wallet: ${response.walletName}",
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    _razorpay.clear();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = screenHeight - keyboardHeight;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxHeight < 700;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: isSmallScreen ? 20 : 40,
                  bottom: math.max(24, keyboardHeight + 24),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header with animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  isSmallScreen ? 16 : 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.payment,
                                  size: isSmallScreen ? 50 : 60,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: isSmallScreen ? 16 : 24),
                              Text(
                                'SecurePay',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 28 : 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Fast & Secure Payments',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 16,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: isSmallScreen ? 30 : 60),

                      // Payment Card
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            padding: EdgeInsets.all(isSmallScreen ? 24 : 32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Enter Payment Amount',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 20 : 24,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF2D3748),
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: isSmallScreen ? 24 : 40),

                                // Amount Input Field
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7FAFC),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 2,
                                    ),
                                  ),
                                  child: TextField(
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 18 : 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Rs 0.00',
                                      hintStyle: TextStyle(
                                        color: const Color(0xFFA0AEC0),
                                        fontSize: isSmallScreen ? 18 : 20,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(
                                        isSmallScreen ? 16 : 20,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: isSmallScreen ? 20 : 32),

                                // Quick Amount Buttons
                                Text(
                                  'Quick Select',
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4A5568),
                                  ),
                                ),
                                SizedBox(height: isSmallScreen ? 12 : 16),
                                Row(
                                  children: [
                                    _buildQuickAmountButton(
                                      'Rs100',
                                      100,
                                      isSmallScreen,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildQuickAmountButton(
                                      'Rs500',
                                      500,
                                      isSmallScreen,
                                    ),
                                    const SizedBox(width: 12),
                                    _buildQuickAmountButton(
                                      'Rs1000',
                                      1000,
                                      isSmallScreen,
                                    ),
                                  ],
                                ),

                                SizedBox(height: isSmallScreen ? 24 : 40),

                                // Pay Button
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: isSmallScreen ? 50 : 56,
                                  child: ElevatedButton(
                                    onPressed: _isProcessing
                                        ? null
                                        : () {
                                            double? amount = double.tryParse(
                                              amountController.text,
                                            );
                                            if (amount != null && amount > 0) {
                                              openCheckout(amount);
                                            } else {
                                              Fluttertoast.showToast(
                                                msg:
                                                    "Please enter a valid amount",
                                                backgroundColor: Colors.orange,
                                                textColor: Colors.white,
                                              );
                                            }
                                          },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF667eea),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 8,
                                      shadowColor: const Color(
                                        0xFF667eea,
                                      ).withOpacity(0.3),
                                    ),
                                    child: _isProcessing
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: isSmallScreen ? 16 : 20,
                                                height: isSmallScreen ? 16 : 20,
                                                child:
                                                    const CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                            Color
                                                          >(Colors.white),
                                                    ),
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                'Processing...',
                                                style: TextStyle(
                                                  fontSize: isSmallScreen
                                                      ? 16
                                                      : 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.security,
                                                size: isSmallScreen ? 20 : 24,
                                              ),
                                              const SizedBox(width: 12),
                                              Text(
                                                'Pay Securely',
                                                style: TextStyle(
                                                  fontSize: isSmallScreen
                                                      ? 16
                                                      : 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),

                                SizedBox(height: isSmallScreen ? 12 : 16),

                                // Security Note
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lock,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '256-bit SSL encrypted',
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 12 : 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: isSmallScreen ? 16 : 20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAmountButton(String label, int amount, bool isSmallScreen) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: isSmallScreen ? 40 : 44,
        child: OutlinedButton(
          onPressed: () {
            amountController.text = amount.toString();
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF667eea), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: const Color(0xFF667eea),
              fontWeight: FontWeight.w500,
              fontSize: isSmallScreen ? 12 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
