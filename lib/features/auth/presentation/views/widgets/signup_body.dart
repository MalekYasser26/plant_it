import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_it/constants/constants.dart';
import 'package:plant_it/features/auth/presentation/view_model/auth_cubit.dart';
import 'package:plant_it/features/auth/presentation/views/log_in_view.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/confirm_password_field.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/cust_text_field.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/email_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/join_through_widget.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/login_button.dart';
import 'package:plant_it/features/auth/presentation/views/widgets/password_widget.dart';
import 'package:plant_it/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:plant_it/features/cust_nav_bar/presentation/views/cust_nav_bar_selection_view.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_cubit.dart';
import 'package:plant_it/features/favourites/presentation/view_model/liked_plants_cubit.dart';
import 'package:plant_it/features/home/presentation/view_model/home_product_cubit.dart';
import 'package:plant_it/features/profile/presentation/view_model/profile_cubit.dart';
import 'package:plant_it/features/ratings_cubit/ratings_cubit.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sCubit = context.read<AuthCubit>();
    var pCubit = context.read<ProfileCubit>();
    var hCubit = context.read<HomeProductsCubit>();
    var rCubit = context.read<RatingsCubit>();
    var lCubit = context.read<LikedPlantsCubit>();
    var l2Cubit = context.read<LikedCubit>();
    var cCubit = context.read<CartCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.basicallyWhite,
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignupSuccessState) {
                  lCubit.getRecentlyLikedProducts(sCubit.userID, true);
                  pCubit.getRecentlySavedProducts(true);
                  hCubit.fetchProducts(l2Cubit.getLikedProducts(sCubit.userID),true);
                  lCubit.getProductSuggestions(true);
                  pCubit.getRecentlyPurchasedProducts(true, sCubit.userID);
                  cCubit.getCartItems();
                  rCubit.getProductRatings(true);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CustNavBarSelectionView(currentIndex: 1),
                    ),
                  );
                } else if (state is SignupFailureState) {
                  // Show a SnackBar with the error message on failure
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        sCubit.errorMsg,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: AppColors.darkGreen,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagesCust.logo,
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: getResponsiveSize(context, fontSize: 32),
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustTextField(
                        text: "Name",
                        custIcon: const Icon(Icons.person),
                        aboveText: "Your name",
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      CustTextField(
                        text: "Address",
                        custIcon: const Icon(Icons.person),
                        aboveText: "Your address",
                        controller: addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.streetAddress,
                      ),
                      CustTextField(
                        text: "Phone",
                        custIcon: const Icon(Icons.phone),
                        aboveText: "Your phone number",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      EmailField(
                        aboveText: "Email",
                        controller: emailController,
                      ),
                      const SizedBox(height: 10),
                      PasswordField(
                        aboveText: "Password",
                        controller: passwordController,
                      ),
                      const SizedBox(height: 10),
                      ConfirmPasswordField(
                        controller: confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      // Show circular progress indicator or button based on state
                      state is SignupLoadingState
                          ? const CircularProgressIndicator(
                              color: AppColors.darkGreen,
                            )
                          : CustButton(
                              text: "Sign up",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  sCubit.signUp(
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    phoneController.text,
                                    addressController.text,
                                  );
                                }
                              },
                            ),
                      const SizedBox(height: 5),
                      const JoinThroughWidget(),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize:
                                  getResponsiveSize(context, fontSize: 14),
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize:
                                      getResponsiveSize(context, fontSize: 14),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.darkGreen),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginView(),
                                      ));
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
