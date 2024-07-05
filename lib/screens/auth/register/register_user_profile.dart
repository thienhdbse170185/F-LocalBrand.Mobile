import 'dart:convert';
import 'dart:io';

import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/features/auth/bloc/auth_bloc.dart';
import 'package:f_localbrand/features/auth/dto/register_dto.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class RegisterUserProfile extends StatefulWidget {
  const RegisterUserProfile(
      {super.key,
      required this.username,
      required this.email,
      required this.password,
      required this.confirm});
  final String username;
  final String email;
  final String password;
  final String confirm;

  @override
  State<RegisterUserProfile> createState() => _RegisterUserProfileState();
}

class _RegisterUserProfileState extends State<RegisterUserProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    final phoneRegExp = RegExp(r'^\+?[0-9]{7,15}$');
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final phone = _phoneController.text.trim();
      final address = _addressController.text.trim();

      String imagePath = '';
      if (_imageFile != null) {
        List<int> imageBytes = await _imageFile!.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        imagePath = base64Image;
        print(base64Image);
      }

      final user = RegisterDto(
        username: widget.username,
        password: widget.password,
        confirm: widget.confirm,
        fullName: name,
        email: widget.email,
        phone: phone,
        address: address,
        image: imagePath,
      );

      try {
        context.read<AuthBloc>().add(AuthRegisterStarted(user));
      } catch (e) {
        print('Error creating user profile: $e');
        SnackbarUtil.showSnackbarError(
            context, 'Failed to create user profile');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) {
          setState(() {
            _isLoading = false;
          });
          SnackbarUtil.showSnackbarSuccess(
              context, 'Register profile success!');
          context.go(RouteName.home);
        } else if (state is AuthRegisterFailure) {
          setState(() {
            _isLoading = false;
          });
          SnackbarUtil.showSnackbarError(context, 'Register profile failed!');
        } else if (state is AuthRegisterInProgress) {
          setState(() {
            _isLoading = true;
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true, // Set to true to avoid bottom insets
        appBar: AppBar(
          leading: CustomBackButton(),
        ),
        body: SafeArea(
          // Use SafeArea to avoid UI elements being cut off
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, left: 36, right: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Complete Your Profile',
                    style: textTheme.headlineLarge,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: 350,
                      child: Text(
                        'Don\'t worry, only you can see your personal data. No one else will be able to see it.',
                        style: textTheme.bodyMedium
                            ?.copyWith(color: colorScheme.outline),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 56,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: _imageFile != null
                                    ? FileImage(File(_imageFile!.path))
                                    : null,
                                child: _imageFile == null
                                    ? FaIcon(
                                        FontAwesomeIcons.solidUser,
                                        size: 48,
                                        color: Colors.grey,
                                      )
                                    : null,
                              ),
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: _pickImage,
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorScheme.primary,
                                        border: Border.all(
                                            color: Colors.white, width: 1.0)),
                                    child: Center(
                                      child: FaIcon(
                                        FontAwesomeIcons.pencil,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 96,
                                  child: TextFormField(
                                    autocorrect: false,
                                    autofocus: false,
                                    keyboardType: TextInputType.text,
                                    controller: _nameController,
                                    validator: _validateName,
                                    decoration: InputDecoration(
                                        hintText: "Full Name",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                    style: textTheme.bodyLarge,
                                  ),
                                ),
                                SizedBox(
                                  height: 96,
                                  child: TextFormField(
                                    autocorrect: false,
                                    autofocus: false,
                                    keyboardType: TextInputType.phone,
                                    controller: _phoneController,
                                    validator: _validatePhone,
                                    decoration: InputDecoration(
                                        hintText: "Phone Number (+84)",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                    style: textTheme.bodyLarge,
                                  ),
                                ),
                                SizedBox(
                                  height: 96,
                                  child: TextFormField(
                                    autocorrect: false,
                                    autofocus: false,
                                    keyboardType: TextInputType.text,
                                    controller: _addressController,
                                    validator: _validateAddress,
                                    decoration: InputDecoration(
                                        hintText: "Address",
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 20),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        )),
                                    style: textTheme.bodyLarge,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  width: double.infinity,
                                  height: 65,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _submitForm,
                                    child: _isLoading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            'Complete Profile',
                                            style: textTheme.headlineSmall
                                                ?.copyWith(color: Colors.white),
                                          ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
