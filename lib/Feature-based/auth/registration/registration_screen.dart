
// import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
// import 'dart:ui';
// import 'package:madhanvasu_app/data/Api_services/user_api_services.dart';
// import 'package:madhanvasu_app/madhanvasu_lib/aswini_screens/views/login_screen.dart';
//
// import '../login_view/loginScreen.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});
//
//   @override
//   _RegistrationScreenState createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//   bool _agreedToTerms = false;
//
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             // colors: [
//             //   // Color(0xFFfab783), // Soft peach
//             //   Color(0xFFFFF5E4),
//             //   Color(0xFFFFF5E4), // Light cream
//             // ],
//             colors: [Color(0xFFFFF5E8), Color(0xFFFFF599)],
//
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 100, bottom: 100),
//             child: Column(
//               children: <Widget>[
//                 FadeInUp(
//                   duration: const Duration(milliseconds: 1600),
//                   child: Image.asset(
//                     'assets/App_logo.png',
//                     height: 150,
//                     width: 200,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: <Widget>[
//                         FadeInUp(
//                           duration: Duration(milliseconds: 1800),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Container(
//                               padding: EdgeInsets.all(2),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFFFF5E4),
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 border: Border.all(
//                                   color: Color(0xFFfab783),
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: _buildTextField(
//                                 controller: _nameController,
//                                 hintText: "Full Name",
//                                 icon: Icons.person,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your full name";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         FadeInUp(
//                           duration: Duration(milliseconds: 1800),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Container(
//                               padding: EdgeInsets.all(2),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFFFF5E4),
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 border: Border.all(
//                                   color: Color(0xFFfab783),
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: _buildTextField(
//                                 controller: _emailController,
//                                 hintText: "Email",
//                                 icon: Icons.email,
//                                 keyboardType: TextInputType.emailAddress,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your email";
//                                   }
//                                   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                                       .hasMatch(value)) {
//                                     return "Please enter a valid email";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         FadeInUp(
//                           duration: Duration(milliseconds: 1800),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Container(
//                               padding: EdgeInsets.all(2),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFFFF5E4),
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 border: Border.all(
//                                   color: Color(0xFFfab783),
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: _buildTextField(
//                                 controller: _phoneController,
//                                 hintText: "Phone Number",
//                                 icon: Icons.phone,
//                                 keyboardType: TextInputType.phone,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter your phone number";
//                                   }
//                                   if (value.length < 10) {
//                                     return "Phone number must be at least 10 digits";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         FadeInUp(
//                           duration: Duration(milliseconds: 1800),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Container(
//                               padding: EdgeInsets.all(2),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFFFF5E4) ,
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 border: Border.all(
//                                   color: Color(0xFFfab783),
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: _buildTextField(
//                                 controller: _passwordController,
//                                 hintText: "Password",
//                                 icon: Icons.lock,
//                                 obscureText: _obscurePassword,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter a password";
//                                   }
//                                   if (value.length < 6) {
//                                     return "Password must be at least 6 characters";
//                                   }
//                                   return null;
//                                 },
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _obscurePassword ? Icons.visibility_off : Icons.visibility,
//                                     color: Color(0xFFe57c42),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _obscurePassword = !_obscurePassword;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         FadeInUp(
//                           duration: Duration(milliseconds: 1800),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(30.0),
//                             child: Container(
//                               padding: EdgeInsets.all(2),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFFFF5E4),
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 border: Border.all(
//                                   color: Color(0xFFfab783),
//                                   width: 1.5,
//                                 ),
//                               ),
//                               child: _buildTextField(
//                                 controller: _confirmPasswordController,
//                                 hintText: "Confirm Password",
//                                 icon: Icons.lock_outline,
//                                 obscureText: _obscureConfirmPassword,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please confirm your password";
//                                   }
//                                   if (value != _passwordController.text) {
//                                     return "Passwords do not match";
//                                   }
//                                   return null;
//                                 },
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//                                     color: Color(0xFFe57c42),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _obscureConfirmPassword = !_obscureConfirmPassword;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         FadeInUp(
//                           duration: Duration(milliseconds: 1900),
//                           child: CheckboxListTile(
//                             controlAffinity: ListTileControlAffinity.leading,
//                             contentPadding: EdgeInsets.zero,
//                             activeColor: Color(0xFFe57c42),
//                             title: GestureDetector(
//                               onTap: () {
//                                      // Optional: Show terms in a dialog or navigate to a new screen
//                               },
//                               child: Text.rich(
//                                 TextSpan(
//                                   text: 'I agree to the ',
//                                   style: TextStyle(color: Colors.black),
//                                   children: [
//                                     TextSpan(
//                                       text: 'Terms & Conditions',
//                                       style: TextStyle(
//                                         color: Color(0xFFe57c42),
//                                         decoration: TextDecoration.underline,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             value: _agreedToTerms,
//                             onChanged: (value) {
//                               setState(() {
//                                 _agreedToTerms = value!;
//                               });
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         FadeInUp(
//                           duration: Duration(milliseconds: 2000),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 if (!_agreedToTerms) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("You must agree to the Terms & Conditions "),
//                                       backgroundColor: Colors.red,
//                                     ),
//                                   );
//                                   return;
//                                 }
//                                 if (_formKey.currentState!.validate()) {
//                                   final success = await ApiService.registerUser(
//                                     name: _nameController.text.trim(),
//                                     email: _emailController.text.trim(),
//                                     phone: _phoneController.text.trim(),
//                                     password: _passwordController.text.trim(),
//                                   );
//                                   if (success) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text("Registration successful! Please login."),
//                                         backgroundColor: Colors.green,
//                                       ),
//                                     );
//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(builder: (context) => Login_Screen(toggleTheme: () {  },)),
//                                     );
//                                   }
//                                   else {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text("Registration failed!       Please try again."),
//                                         backgroundColor: Colors.red,
//                                       ),
//                                     );
//                                   }
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFFe57c42),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 15),
//                                 minimumSize: Size(double.infinity, 50),
//                                 elevation: 5,
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   "Sign Up",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         FadeInUp(
//                           duration: Duration(milliseconds: 2100),
//                           child: TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => Login_Screen (toggleTheme: () {},)),
//                               );
//                             },
//                             child: Text(
//                               "Already have an account? Log In",
//                               style: TextStyle(
//                                 color: Color(0xFFe57c42),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     bool obscureText = false,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//     Widget? suffixIcon,
//   })
//   {
//     return Container(
//       padding: EdgeInsets.all(4.0),
//       child: TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: keyboardType,
//         validator: validator,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey[700]),
//           prefixIcon: Icon(
//             icon,
//             color: Color(0xFFe57c42),
//           ),
//           suffixIcon: suffixIcon,
//           errorStyle: TextStyle(
//             color: Colors.red,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }




//////////


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:madhanvasu_app/Feature-based/auth/registration/register_controller/registration_controller.dart';
import '../../states&districts/districts/districts_model.dart';
import '../../states&districts/mandals/mandals_model.dart';
import '../../states&districts/states/States_model.dart';
import '../../states&districts/villages/villages_model.dart';
import '../login_view/loginScreen.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF5E8), Color(0xFFFFF599)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              FadeInUp(
                duration: Duration(milliseconds: 1600),
                child: Image.asset('assets/App_logo.png',
                    height: 150, width: 200),
              ),
              SizedBox(height: 30),
              Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ..._buildTextField(
                          obs: controller.name,
                          icon: Icons.person,
                          hint: 'Full Name',
                          validator: (v) =>
                          (v == null || v.isEmpty) ? 'Please enter your full name' : null
                      ),
                      SizedBox(height: 20),
                      ..._buildTextField(
                        obs: controller.email,
                        icon: Icons.email,
                        hint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please enter your email';
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ..._buildTextField(
                        obs: controller.phone,
                        icon: Icons.phone,
                        hint: 'Phone Number',
                        keyboardType: TextInputType.phone,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Please enter your phone number';
                          if (v.length != 10) return 'Phone number must be exactly 10 digits';
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Obx(() => Column(
                        children: [
                          _customField(
                            controller: null,
                            hint: 'Password',
                            icon: Icons.lock,
                            obscure: controller.obscurePassword.value,
                            onChanged: (v) => controller.password(v),
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Please enter a password';
                              if (v.length < 6) return 'Password must be at least 6 characters';
                              return null;
                            },
                            suffix: IconButton(
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFFe57c42),
                              ),
                              onPressed: controller.togglepassword,
                            ),
                          ),
                          SizedBox(height: 20),
                          _customField(
                            controller: null,
                            hint: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscure: controller.obscureConfirm.value,
                            onChanged: (v) => controller.confirmPassword,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Please confirm your password';
                              if (v != controller.password.value) return 'Passwords do not match';
                              return null;
                            },
                            suffix: IconButton(
                              icon: Icon(
                                controller.obscureConfirm.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFFe57c42),
                              ),
                              onPressed: controller.toggleConfirm,
                            ),
                          ),
                        ],
                      )),

                      SizedBox(height: 20),

                      /// STATE DROPDOWN
                      Obx(() {
                        final states = controller.stateController.statesList;

                        if (controller.stateController.isLoading.value) {
                          return const CircularProgressIndicator();
                        }

                        return DropdownButtonFormField<StatesModelData>(
                          isExpanded: true,
                          value: controller.selectedState.value,
                          decoration: InputDecoration(
                            labelText: 'Select State',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: const Color(0xFFFFF5E4),
                            prefixIcon: const Icon(Icons.flag, color: Color(0xFFe57c42)),
                          ),
                          items: states.map((state) {
                            return DropdownMenuItem<StatesModelData>(
                              value: state,
                              child: Text(state.stateName ?? ''),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            controller.selectedState.value = value;
                            controller.selectedDistrict.value = null;

                            // Clear districts first
                            controller.districtController.clearDistricts();

                            if (value != null) {
                              await controller.districtController.fetchDistricts(value.id!);

                              // Log the result
                              if (controller.districtController.districtList.isEmpty) {
                                print('No districts found for state: ${value.stateName}');
                              } else {
                                print('Districts loaded for state: ${value.stateName}');
                                controller.districtController.districtList.forEach((d) {
                                  print('District: ${d.districtName}');
                                });
                              }
                            }
                          },

                          validator: (value) => value == null ? 'Please select a state' : null,
                        );
                      }),

                      const SizedBox(height: 20),

                      /// DISTRICT DROPDOWN
                      /// DISTRICT DROPDOWN
                      Obx(() {
                        final selectedState = controller.selectedState.value;
                        final districts = controller.districtController.districtList;
                        final isDistrictLoading = controller.districtController.isLoading.value;

                        if (selectedState == null) {
                          return const SizedBox();
                        }

                        if (isDistrictLoading) {
                          return const CircularProgressIndicator();
                        }

                        if (districts.isEmpty) {
                          print('No districts available for the selected state.');
                          return const SizedBox();
                        }

                        return DropdownButtonFormField<DistrictData>(
                          isExpanded: true,
                          value: controller.selectedDistrict.value,
                          decoration: InputDecoration(
                            labelText: 'Select District',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: const Color(0xFFFFF5E4),
                            prefixIcon: const Icon(Icons.location_city, color: Color(0xFFe57c42)),
                          ),
                          items: districts.map((district) {
                            return DropdownMenuItem<DistrictData>(
                              value: district,
                              child: Text(district.districtName),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            controller.selectedDistrict.value = value;
                            controller.selectedMandal.value = null;

                            // Clear previous mandals
                            controller.mandalController.clearMandals();

                            if (value != null && controller.selectedState.value != null) {
                              await controller.mandalController.fetchMandals(
                                stateId: controller.selectedState.value!.id!,
                                districtId: value.id!,
                              );

                              if (controller.mandalController.mandalList.isEmpty) {
                                print('No mandals found for district: ${value.districtName}');
                              } else {
                                controller.mandalController.mandalList.forEach((m) {
                                  print('Mandal: ${m.mandalName}');
                                });
                              }
                            }
                          },
                          validator: (value) => value == null ? 'Please select a district' : null,
                        );
                      }),


                      SizedBox(height: 20),

                      /// MANDAL DROPDOWN
                      Obx(() {
                        final selectedDistrict = controller.selectedDistrict.value;
                        final mandals = controller.mandalController.mandalList;
                        final isMandalLoading = controller.mandalController.isLoading.value;

                        // Hide mandal dropdown if no district selected or mandal list is empty
                        if (selectedDistrict == null || (!isMandalLoading && mandals.isEmpty)) {
                          return const SizedBox();
                        }

                        if (isMandalLoading) {
                          return const CircularProgressIndicator();
                        }

                        return DropdownButtonFormField<MandalData>(
                          isExpanded: true,
                          value: controller.selectedMandal.value,
                          decoration: InputDecoration(
                            labelText: 'Select Mandal',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: const Color(0xFFFFF5E4),
                            prefixIcon: const Icon(Icons.map_outlined, color: Color(0xFFe57c42)),
                          ),
                          items: mandals.map((mandal) {
                            return DropdownMenuItem<MandalData>(
                              value: mandal,
                              child: Text(mandal.mandalName),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            controller.selectedMandal.value = value;
                            controller.selectedVillage.value = null;

                            // Clear villages first
                            controller.villageController.clearVillages();

                            if (value != null && controller.selectedState.value != null && controller.selectedDistrict.value != null) {
                              await controller.villageController.fetchVillages(
                                stateId: controller.selectedState.value!.id!,
                                districtId: controller.selectedDistrict.value!.id!,
                                mandalId: value.id!,
                              );

                              if (controller.villageController.villageList.isEmpty) {
                                print('No villages found for mandal: ${value.mandalName}');
                              } else {
                                controller.villageController.villageList.forEach((v) {
                                  print('Village: ${v.villageName}');
                                });
                              }
                            }
                          },

                          validator: (value) => value == null ? 'Please select a mandal' : null,
                        );
                      }),
                      SizedBox(height: 20),

                      /// VILLAGE DROPDOWN
                      Obx(() {
                        final selectedState = controller.selectedState.value;
                        final selectedDistrict = controller.selectedDistrict.value;
                        final selectedMandal = controller.selectedMandal.value;
                        final villages = controller.villageController.villageList;
                        final isVillageLoading = controller.villageController.isLoading.value;

                        // Hide if no mandal selected or no villages after loading
                        if (selectedMandal == null || (!isVillageLoading && villages.isEmpty)) {
                          return const SizedBox();
                        }

                        if (isVillageLoading) {
                          return const CircularProgressIndicator();
                        }

                        return DropdownButtonFormField<VillageData>(
                          isExpanded: true,
                          value: controller.selectedVillage.value,
                          decoration: InputDecoration(
                            labelText: 'Select Village',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: const Color(0xFFFFF5E4),
                            prefixIcon: const Icon(Icons.home_outlined, color: Color(0xFFe57c42)),
                          ),
                          items: villages.map((village) {
                            return DropdownMenuItem<VillageData>(
                              value: village,
                              child: Text(village.villageName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.selectedVillage.value = value;
                            print('Selected village: ${value?.villageName}');
                          },
                          validator: (value) => value == null ? 'Please select a village' : null,
                        );
                      }),



                      SizedBox(height: 20),


                      FadeInUp(
                        duration: Duration(milliseconds: 1900),
                        child: Obx(() => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          activeColor: Color(0xFFe57c42),
                          title: Text.rich(TextSpan(
                            text: 'I agree to the ',
                            children: [
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(
                                  color: Color(0xFFe57c42),
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                            style: TextStyle(color: Colors.black),
                          )),
                          value: controller.agreed.value,
                          onChanged: controller.toggleAgree,
                        )),
                      ),
                      SizedBox(height: 20),
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: ElevatedButton(
                          onPressed: controller.register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFe57c42),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                            minimumSize: Size(double.infinity, 50),
                            elevation: 5,
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      FadeInUp(
                        duration: Duration(milliseconds: 2100),
                        child: TextButton(
                          onPressed: () => Get.to(() => Login_Screen(toggleTheme: () {})),
                          child: Text(
                            'Already have an account? Log In',
                            style: TextStyle(
                              color: Color(0xFFe57c42),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
    );
  }

  List<Widget> _buildTextField({
    required RxString obs,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return [
      FadeInUp(
        duration: Duration(milliseconds: 1800),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Color(0xFFFFF5E4),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Color(0xFFfab783), width: 1.5),
            ),
            child: TextFormField(
              onChanged: obs,
              keyboardType: keyboardType,
              validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: Icon(icon, color: Color(0xFFe57c42)),
              ),
            ),
          ),
        ),
      )
    ];
  }

  Widget _customField({
    String? hint,
    IconData? icon,
    bool obscure = false,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
    Widget? suffix,
    TextEditingController? controller,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Color(0xFFFFF5E4),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Color(0xFFfab783), width: 1.5),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscure,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[700]),
              prefixIcon: Icon(icon, color: Color(0xFFe57c42)),
              suffixIcon: suffix,
            ),
          ),
        ),
      );
}
