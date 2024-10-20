import 'package:flutter/material.dart';

// Entry point of the application
void main() {
  runApp(const MyApp());
}

// MyApp widget: Main application widget that sets up the MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page', // Title of the app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Theme color scheme
        useMaterial3: true, // Use Material Design 3
      ),
      home: const LoginPage(title: 'Login'), // Set the home widget to LoginPage
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

// LoginPage widget: Stateful widget for the login interface
class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title; // Title of the login page

  @override
  State<LoginPage> createState() => _LoginPageState(); // Create state for the login page
}

// State class for LoginPage
class _LoginPageState extends State<LoginPage> {
  // Controllers for email and password text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false; // To toggle password visibility
  bool _emailError = false; // To indicate email field error
  bool _passwordError = false; // To indicate password field error

  @override
  void dispose() {
    _emailController.dispose(); // Dispose of the email controller
    _passwordController.dispose(); // Dispose of the password controller
    super.dispose();
  }

  // Function to toggle the visibility of the password
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible; // Toggle the visibility state
    });
  }

  // Function to handle login button click
  void _login() {
    String email = _emailController.text.trim(); // Get trimmed email input
    String password = _passwordController.text.trim(); // Get trimmed password input

    // Reset error states
    setState(() {
      _emailError = false; // Clear email error
      _passwordError = false; // Clear password error
    });

    // Validate the input fields
    if (email.isEmpty) {
      setState(() {
        _emailError = true; // Set email error state if empty
      });
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = true; // Set password error state if empty
      });
    }

    // If both fields are filled, proceed with login
    if (email.isNotEmpty && password.isNotEmpty) {
      print('Email: $email, Password: $password'); // Print email and password (for demonstration)

      // Clear the text fields after login
      _emailController.clear(); // Clear email field
      _passwordController.clear(); // Clear password field
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 41, 41, 41), // App bar color
        title: Text(
          widget.title, // Title from the widget
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: Colors.black, // Background color of the page
      body: Center(
        child: Container(
          width: 680, // Width of the container
          height: 650, // Height of the container
          padding: const EdgeInsets.all(20), // Padding around the container
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column
            children: [
              const Text(
                "Login", // Login title
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30), // Spacer

              // Email TextField with validation
              TextField(
                controller: _emailController, // Set email controller
                keyboardType: TextInputType.emailAddress, // Keyboard type for email
                style: const TextStyle(color: Colors.white), // Text style
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white12, // Fill color of the field
                  labelText: 'Email', // Label for the field
                  labelStyle: const TextStyle(color: Colors.white70), // Label style
                  hintText: 'Enter your email', // Hint text
                  hintStyle: const TextStyle(color: Colors.white54), // Hint text style
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    borderSide: BorderSide(
                      color: _emailError ? Colors.red : Colors.transparent, // Red border if there's an error
                    ),
                  ),
                  prefixIcon: const Icon(Icons.email, color: Colors.white), // Icon for the email field
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners when focused
                    borderSide: BorderSide(
                      color: _emailError ? Colors.red : Colors.orange, // Change color based on error
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0), // Spacer

              // Password TextField with eye icon to toggle visibility
              TextField(
                controller: _passwordController, // Set password controller
                obscureText: !_isPasswordVisible, // Toggle password visibility
                style: const TextStyle(color: Colors.white), // Text style
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white12, // Fill color of the field
                  labelText: 'Password', // Label for the field
                  labelStyle: const TextStyle(color: Colors.white70), // Label style
                  hintText: 'Enter your password', // Hint text
                  hintStyle: const TextStyle(color: Colors.white54), // Hint text style
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    borderSide: BorderSide(
                      color: _passwordError ? Colors.red : Colors.transparent, // Red border if there's an error
                    ),
                  ),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white), // Icon for the password field
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off, // Toggle visibility icon
                      color: Colors.white,
                    ),
                    onPressed: _togglePasswordVisibility, // Function to toggle password visibility
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners when focused
                    borderSide: BorderSide(
                      color: _passwordError ? Colors.red : Colors.orange, // Change color based on error
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Spacer

              // Login Button
              MouseRegion(
                cursor: SystemMouseCursors.click, // Change cursor on hover
                child: ElevatedButton(
                  onPressed: _login, // Function to call on button press
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.orange.withOpacity(0.8); // Change color on hover
                        } else if (states.contains(MaterialState.pressed)) {
                          return Colors.orange.withOpacity(0.6); // Change color on press
                        }
                        return Colors.orange; // Default color
                      },
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 15)), // Button padding
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                  ),
                  child: const Text(
                    'Login', // Button text
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Error message display
              if (_emailError || _passwordError) ...[
                const SizedBox(height: 10), // Spacer
                const Text(
                  'Email and Password are required!', // Error message
                  style: TextStyle(color: Colors.red, fontSize: 14), // Error message style
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
