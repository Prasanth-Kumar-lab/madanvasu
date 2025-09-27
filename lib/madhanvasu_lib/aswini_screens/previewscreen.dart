import 'package:flutter/material.dart';
// import 'package:real_estate/ui_screens/post_propertys.dart';

class PreviewDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> formData;

  const PreviewDetailsScreen({super.key, required this.formData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('     Your Property Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFFe57c42)),
            onPressed: () {
              Navigator.of(context).pop(); // Go back to edit form
            },
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildDetailCard('Property Type', formData['propertyType']),
              _buildDetailCard('Title', formData['title']),
              _buildDetailCard('Price', '₹${formData['price']}'),
              _buildDetailCard('Location', formData['location']),
              _buildDetailCard('Landmark', formData['landmark']),
              _buildDetailCard('Facing', formData['facingDirection']),
              _buildDetailCard('Description', formData['description']),
              if (formData['propertyType'] == 'Land') ...[
                _buildDetailCard('Length (ft)', formData['length']),
                _buildDetailCard('Width (ft)', formData['width']),
                _buildDetailCard('Total Area (sq.ft)', formData['area']),
                _buildDetailCard('Land Type', formData['landType']),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildPlanDialog(context),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFe57c42),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: const Text('Confirm and Proceed', style: TextStyle(color: Colors.white)),
             )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanDialog(BuildContext context) {
    String selectedPlan = '1 Month';
    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Choose a Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['1 Month', '3 Months', '6 Months']
            .map(
              (plan) => RadioListTile<String>(
                title: Text(plan),
                value: plan,
                groupValue: selectedPlan,
                onChanged: (value) {
                  setState(() => selectedPlan = value!);
                },
              ),
            )
            .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pop(context); // Close dialog
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const PaymentScreen()),
                // );   ///Balu
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
  Widget _buildDetailCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFe4b201), width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value.isNotEmpty ? value : '-',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

}
