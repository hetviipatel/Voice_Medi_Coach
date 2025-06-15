import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>(); // Added GlobalKey for form validation
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _professionalIdController = TextEditingController(); // New field for Health Worker
  final TextEditingController _specializationController = TextEditingController(); // New field for Health Worker

  String _selectedRole = 'User'; // Default role
  bool _obscurePassword = true; // For password visibility toggle
  bool _obscureConfirmPassword = true; // For confirm password visibility toggle

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _professionalIdController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blueAccent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form( // Wrap with Form for validation
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up to get started!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),

                // Role Selection
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedRole,
                      isExpanded: true,
                      items: ['User', 'Health Worker']
                          .map((role) => DropdownMenuItem(
                                value: role,
                                child: Text(role),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField( // Changed to TextFormField for validation
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField( // Changed to TextFormField for validation
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Conditional fields for Health Worker
                if (_selectedRole == 'Health Worker') ...[
                  TextFormField(
                    controller: _professionalIdController,
                    decoration: InputDecoration(
                      labelText: 'Professional ID (e.g., License Number)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.assignment_ind),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Professional ID is required for Health Workers';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _specializationController,
                    decoration: InputDecoration(
                      labelText: 'Specialization',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      prefixIcon: const Icon(Icons.medical_information),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Specialization is required for Health Workers';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                ],

                TextFormField( // Changed to TextFormField for validation
                  controller: _passwordController,
                  obscureText: _obscurePassword, // Use state variable for visibility
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton( // Password visibility toggle
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField( // Changed to TextFormField for validation
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword, // Use state variable for visibility
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.lock_open),
                    suffixIcon: IconButton( // Confirm password visibility toggle
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) { // Validate the form
                        // TODO: Implement user registration logic (e.g., Firebase Email/Password Auth)
                        // Consider replacing print with a logging framework in production
                        print('Sign Up button pressed for: $_selectedRole');
                        print('Name: ${_nameController.text}');
                        print('Email: ${_emailController.text}');
                        if (_selectedRole == 'Health Worker') {
                          print('Professional ID: ${_professionalIdController.text}');
                          print('Specialization: ${_specializationController.text}');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Social Login Options
                Center(
                  child: Text(
                    'Or sign up with',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSocialButton('assets/icons/google.svg', 'Google', () {
                      // TODO: Implement Google Sign-Up
                      // Temporarily redirect to login page for frontend demonstration
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                    buildSocialButton('assets/icons/apple.svg', 'Apple', () {
                      // TODO: Implement Apple Sign-Up
                      // Temporarily redirect to login page for frontend demonstration
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                    buildSocialButton('assets/icons/facebook.svg', 'Facebook', () {
                      // TODO: Implement Facebook Sign-Up
                      // Temporarily redirect to login page for frontend demonstration
                      Navigator.pushReplacementNamed(context, '/login');
                    }),
                  ],
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSocialButton(String assetPath, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100, // Adjusted width to accommodate text
        height: 100, // Adjusted height
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column( // Added Column for icon and text
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(assetPath, height: 40), // Adjusted icon size
            const SizedBox(height: 8),
            Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
} 