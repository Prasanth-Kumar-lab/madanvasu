import 'package:flutter/material.dart';
// import 'package:real_estate/aswini_screens/previewscreen.dart';

import '../../app/configuration/ themes/app_colors.dart';
import '../aswini_screens/previewscreen.dart';

class PostPropertyScreen extends StatefulWidget {
  const PostPropertyScreen({super.key});

  @override
  State<PostPropertyScreen> createState() => _PostPropertyScreenState();
}

class _PostPropertyScreenState extends State<PostPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _landLengthController = TextEditingController();
  final TextEditingController _landWidthController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  String _propertyType = 'House';
  String _landType = 'Residential';
  String _facingDirection = 'North';

  // ignore: prefer_final_fields
  Map<String, bool> _features = {
    'Parking': false,
    'Garden': false,
    'Swimming Pool': false,
    'Furnished': false,
    'Security': false,
    'Lift': false,
    'Power Backup': false,
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Preview & Confirm'),
          content: const Text(
              'You are about to post your property for ₹2 for 1 day.\n\nPlease Confirm Your Property Details.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewDetailsScreen(
                      formData: {
                        'propertyType': _propertyType,
                        'title': _titleController.text,
                        'price': _priceController.text,
                        'location': _locationController.text,
                        'landmark': _landmarkController.text,
                        'facingDirection': _facingDirection,
                        'description': _descriptionController.text,
                        'length': _landLengthController.text,
                        'width': _landWidthController.text,
                        'area': _areaController.text,
                        'landType': _landType,
                      },
                    ),
                  ),
                );
              },
              child: const Text('OK'),
            ),

          ],
        ),
      );
    }
  }

  Widget _buildCheckbox(String label) {
    return CheckboxListTile(
      value: _features[label],
      title: Text(label),
      onChanged: (val) {
        setState(() {
          _features[label] = val!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Color(0xFFe57c42),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          floatingLabelStyle: const TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFe4b201), width: 2),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required String label,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        ))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          floatingLabelStyle: const TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFe4b201), width: 2),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final Color primaryColor = Colors.black;
    //final Color accentColor = const Color(0xFFFFEB3B);
    final Color backgroundColor = const Color(0xFFFFFDE7);
    final Color cardColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Post a Property'),
        backgroundColor: AppColors.secondary.withOpacity(0.8),

        // backgroundColor: Colors.green.withOpacity(0.8),

        centerTitle: true,
        elevation: 1,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Type
              _buildDropdown(
                value: _propertyType,
                items: [
                  'House',
                  'Land',
                  'Villa',
                  'Office',
                  'Apartment',
                  'Commercial',
                  'Farmhouse',
                ],
                label: 'Property Type',
                onChanged: (value) {
                  setState(() {
                    _propertyType = value!;
                  });
                },
              ),

              // Title
              _buildTextField(
                controller: _titleController,
                label: 'Title',
                validator: (value) =>
                value!.isEmpty ? 'Please enter a title' : null,
              ),

              // Price
              _buildTextField(
                controller: _priceController,
                label: 'Price (₹)',
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Please enter a price' : null,
              ),

              // Location
              _buildTextField(
                controller: _locationController,
                label: 'Location',
                validator: (value) =>
                value!.isEmpty ? 'Please enter a location' : null,
              ),

              // Landmark
              _buildTextField(
                controller: _landmarkController,
                label: 'Nearby Landmark',
                validator: (value) =>
                value!.isEmpty ? 'Please enter a landmark' : null,
              ),
              // Position/Facing Direction
              _buildDropdown(
                value: _facingDirection,
                items: [
                  'North',
                  'East',
                  'South',
                  'West',
                  'North-East',
                  'North-West',
                  'South-East',
                  'South-West',
                ],
                label: 'Facing Direction',
                onChanged: (value) {
                  setState(() {
                    _facingDirection = value!;
                  });
                },
              ),

              // Description
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 4,
              ),

              // Land-specific fields
              if (_propertyType == 'Land') ...[
                const Text(
                  'Land Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _landLengthController,
                        label: 'Length (ft)',
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                        value!.isEmpty ? 'Enter length' : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        controller: _landWidthController,
                        label: 'Width (ft)',
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                        value!.isEmpty ? 'Enter width' : null,
                      ),
                    ),
                  ],
                ),
                _buildTextField(
                  controller: _areaController,
                  label: 'Total Area (sq.ft)',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value!.isEmpty ? 'Enter total area' : null,
                ),
                _buildDropdown(
                  value: _landType,
                  items: [
                    'Residential',
                    'Commercial',
                    'Agricultural',
                    'Industrial',
                    'Institutional',
                    'Forest',
                    'Barren',
                  ],
                  label: 'Land Type',
                  onChanged: (value) {
                    setState(() {
                      _landType = value!;
                    });
                  },
                ),
              ],

              // Features
              const Text(
                'Features',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _features.keys.map((feature) => _buildCheckbox(feature)).toList(),
              ),

              const SizedBox(height: 16),

              // Image Upload Placeholder
              // GestureDetector(
              //   onTap: () {
              //     // Implement image picker logic here
              //   },
              //   child: Container(
              //     height: 150,
              //     decoration: BoxDecoration(
              //       color: Colors.white,//Color(0xFFe4b201).withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(color: Color(0xFFe4b201)),
              //     ),
              //     child: const Center(
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(Icons.camera_alt, size: 40, color: Color(0xFFe57c42)),
              //           Text(
              //             'Upload Images',
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFFe57c42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Post Property',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _landLengthController.dispose();
    _landWidthController.dispose();
    _landmarkController.dispose();
    _positionController.dispose();
    _areaController.dispose();
    super.dispose();
  }
}


class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: const Center(
        child: Text(
          'Payment processing screen goes here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
