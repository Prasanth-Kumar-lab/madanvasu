// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../app/configuration/ themes/app_colors.dart';
// import 'edit_profile_controller.dart';
//
//
// class EditProfileScreen extends StatelessWidget {
//   final controller = Get.put(EditProfileController());
//
//   EditProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Edit Profile"),
//         centerTitle: true,
//         backgroundColor: AppColors.secondary, // Your custom color
//         foregroundColor: Colors.black, // Sets title color
//         iconTheme: const IconThemeData(
//           color: AppColors.black, // Set the back icon color explicitly
//         ),
//       ),
//
//       body: Obx(() {
//         return controller.isUpdating.value
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               _buildTextField("Name", controller.personName),
//               _buildTextField("Mobile", controller.mobileNumber),
//               _buildTextField("Email", controller.email),
//               _buildTextField("Username", controller.username),
//               _buildTextField("Password", controller.password, obscure: true),
//               _buildTextField("Address", controller.address),
//               const SizedBox(height: 20),
//               Center(
//                 child: SizedBox(
//                   width: 150,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       print("Save button clicked");
//                       controller.updateProfile();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       padding: const EdgeInsets.symmetric(vertical: 16), // Adjust vertical size
//                     ),
//                     child: const Text(
//                       "Save Changes",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
//
//   Widget _buildTextField(String label, RxString fieldController, {bool obscure = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0), // Adds vertical gap between fields
//       child: Obx(() => TextField(
//         obscureText: obscure,
//         controller: TextEditingController(text: fieldController.value)
//           ..selection = TextSelection.fromPosition(
//             TextPosition(offset: fieldController.value.length),
//           ),
//         onChanged: (value) => fieldController.value = value,
//         decoration: InputDecoration(
//           filled: true, // Enables background color
//           fillColor: Colors.white, // Sets the inner field color
//           labelText: label,
//           labelStyle: const TextStyle(color: Colors.black87),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: AppColors.secondary),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide(color: AppColors.secondary, width: 2),
//           ),
//         ),
//       )),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/configuration/themes/app_colors.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final controller = Get.put(EditProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F7),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
        elevation: 0,
      ),
      body: Obx(() {
        return controller.isUpdating.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),

          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 30),
              _buildTextField("Full Name", controller.personName,
                  icon: Icons.person),
              _buildTextField("Mobile Number", controller.mobileNumber,
                  icon: Icons.phone),

              _buildTextField("Email Address", controller.email,
                  icon: Icons.email),

              _buildTextField(
                "Username",
                controller.username,
                icon: Icons.account_circle,
                keyboardType: TextInputType.phone,
              ),

              _buildTextField(
                "Password",
                controller.password,
                icon: Icons.lock,
                obscure: true,
                errorText: controller.passwordError,
                isVisibleToggle: controller.isPasswordVisible,
              ),


              _buildTextField("Address", controller.address,
                  icon: Icons.home),
              const SizedBox(height: 30),
              _buildSaveButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Text(
          controller.username.value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          controller.email.value,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTextField(
      String label,
      RxString fieldController, {
        bool obscure = false,
        IconData? icon,
        RxString? errorText,
        RxBool? isVisibleToggle,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Obx(() {
        final isObscure = obscure && (isVisibleToggle != null && !isVisibleToggle.value);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              obscureText: isObscure,
              controller: TextEditingController(text: fieldController.value)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: fieldController.value.length),
                ),
              onChanged: (value) {
                fieldController.value = value;
                if (errorText != null) errorText.value = '';
              },
              decoration: InputDecoration(
                prefixIcon: icon != null ? Icon(icon, color: AppColors.primary) : null,
                suffixIcon: isVisibleToggle != null
                    ? IconButton(
                  icon: Icon(
                    isVisibleToggle.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () => isVisibleToggle.value = !isVisibleToggle.value,
                )
                    : null,
                filled: true,
                fillColor: Colors.white,
                labelText: label,
                labelStyle: const TextStyle(color: Colors.black87),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.secondary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.secondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
            if (errorText != null && errorText.value.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  errorText.value,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      }),
    );
  }


  ///// Save Button

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          controller.updateProfile();
        },
        icon: const Icon(Icons.save, color: Colors.white),
        label: const Text(
          "Save Changes",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}

