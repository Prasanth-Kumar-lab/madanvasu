import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/configuration/ themes/app_colors.dart';
import 'edit_profile_controller.dart';


class EditProfileScreen extends StatelessWidget {
  final controller = Get.put(EditProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.scaffoldbackgroundColor,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: AppColors.secondary, // Your custom color
        foregroundColor: Colors.black, // Sets title color
        iconTheme: const IconThemeData(
          color: AppColors.black, // Set the back icon color explicitly
        ),
      ),

      body: Obx(() {
        return controller.isUpdating.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              _buildTextField("Name", controller.personName),
              _buildTextField("Mobile", controller.mobileNumber),
              _buildTextField("Email", controller.email),
              _buildTextField("Username", controller.username),
              _buildTextField("Password", controller.password, obscure: true),
              _buildTextField("Address", controller.address),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      print("Save button clicked");
                      controller.updateProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16), // Adjust vertical size
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTextField(String label, RxString fieldController, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Adds vertical gap between fields
      child: Obx(() => TextField(
        obscureText: obscure,
        controller: TextEditingController(text: fieldController.value)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: fieldController.value.length),
          ),
        onChanged: (value) => fieldController.value = value,
        decoration: InputDecoration(
          filled: true, // Enables background color
          fillColor: Colors.white, // Sets the inner field color
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.secondary, width: 2),
          ),
        ),
      )),
    );
  }
}
