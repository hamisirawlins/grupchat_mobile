import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grupchat/main.dart';
import 'package:grupchat/models/user.dart';
import 'package:grupchat/modules/app/screens/widgets/pools/non_bordered_button.dart';
import 'package:grupchat/modules/auth/screens/widgets/auth_input_field.dart';
import 'package:grupchat/services/auth_service.dart';
import 'package:grupchat/utils/formatters/formatter.dart';
import 'package:grupchat/widgets/navbar.dart';
import 'package:grupchat/widgets/show_snackbar.dart';

class AddPhoneScreen extends StatefulWidget {
  static const String routeName = '/add-phone';
  final GoogleSignInAccount? user;
  const AddPhoneScreen({super.key, this.user});

  @override
  State<AddPhoneScreen> createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  AuthService authService = AuthService();
  final phoneController = TextEditingController();

  Future<void> updateUserNumber() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        });
    try {
      //Google User Registration
      if (widget.user != null) {
        String phoneNumber =
            UtilFormatter.formatPhoneNumber(phoneController.text.trim());
        final userData = {
          'id': supabase.auth.currentUser!.id,
          'email': widget.user!.email,
          'name': widget.user!.displayName,
          'phone': phoneNumber,
          'profile_img': widget.user!.photoUrl,
        };

        // Insert user data into the database
        await supabase
            .from('users')
            .update(userData)
            .eq('id', supabase.auth.currentUser!.id);

        if (mounted) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeView.routeName, (route) => false);
        }
      } else {
        final UserModel user =
            await authService.getUserDetails(supabase.auth.currentUser!.id);
        String phoneNumber =
            UtilFormatter.formatPhoneNumber(phoneController.text.trim());
        final userData = {
          'id': supabase.auth.currentUser!.id,
          'email': user.email,
          'phone': phoneNumber,
        };

        // Insert user data into the database
        await supabase.from('users').upsert(userData, ignoreDuplicates: false);

        if (mounted) {
          Navigator.pop(context);
          showSnackBar(context, 'Successfully Updated Phone Number!');
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        showSnackBar(context, 'An Error Occurred, Please Try Again Later');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Add An M-Pesa Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Add your phone number to continue'),
            const SizedBox(height: 16),
            AuthInput(
                controller: phoneController,
                hintText: '07XXXXXXXX',
                obscureText: false),
            const SizedBox(height: 16),
            NonBorderedButton(onTap: updateUserNumber, text: 'Add Phone Number')
          ],
        ),
      ),
    );
  }
}
