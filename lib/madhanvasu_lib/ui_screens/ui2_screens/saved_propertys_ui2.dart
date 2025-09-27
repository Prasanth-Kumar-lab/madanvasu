import 'package:flutter/material.dart';

class SavedPropertiesScreen_ui2 extends StatelessWidget {
  final Color primaryColor = Colors.black;
  final Color accentColor = const Color(0xFFFFEB3B);
  final Color backgroundColor = const Color(0xFFFFFDE7);
  final Color cardColor = Colors.white;

  SavedPropertiesScreen_ui2({super.key});

  final List<Map<String, String>> savedProperties = [
    {
      'title': 'Luxury Apartment in Banjara Hills',
      'location': 'Banjara Hills, Hyderabad',
      'price': '₹75,000 / month',
      'type': 'Apartment',
      'area': '2200 sq.ft',
      'contactName': 'John Doe',
      'contactNumber': '+91 98765 43210',
    },
    {
      'title': 'Modern Villa in Gachibowli',
      'location': 'Gachibowli, Hyderabad',
      'price': '₹1,20,000 / month',
      'type': 'Villa',
      'area': '3000 sq.ft',
      'contactName': 'Jane Smith',
      'contactNumber': '+91 87654 32109',
    },
    {
      'title': 'Residential Plot in Madhapur',
      'location': 'Madhapur, Hyderabad',
      'price': '₹30,000 / month',
      'type': 'Land',
      'area': '2000 sq.ft',
      'contactName': 'Alice Brown',
      'contactNumber': '+91 76543 21098',
    },
    {
      'title': 'Premium Flat in Hitech City',
      'location': 'Hitech City, Hyderabad',
      'price': '₹65,000 / month',
      'type': 'Apartment',
      'area': '1800 sq.ft',
      'contactName': 'Bob Wilson',
      'contactNumber': '+91 65432 10987',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Saved Properties - Hyderabad',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body: savedProperties.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 60,
              color: primaryColor.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'No saved properties in Hyderabad yet!',
              style: TextStyle(
                color: primaryColor.withOpacity(0.6),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedProperties.length,
        itemBuilder: (context, index) {
          final property = savedProperties[index];
          return _buildSavedCard(
            title: property['title']!,
            location: property['location']!,
            price: property['price']!,
            type: property['type']!,
            area: property['area']!,
            contactName: property['contactName']!,
            contactNumber: property['contactNumber']!,
          );
        },
      ),
    );
  }

  Widget _buildSavedCard({
    required String title,
    required String location,
    required String price,
    required String type,
    required String area,
    required String contactName,
    required String contactNumber,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Handle tap to view property details
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: primaryColor.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              color: primaryColor.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.apartment,
                          size: 16,
                          color: primaryColor.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$type • $area',
                          style: TextStyle(
                            color: primaryColor.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // _showContactDialog(
                          //   context,         // Correct context reference
                          //   contactName,
                          //   contactNumber,
                          // );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: accentColor.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Contact',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Favorite Icon
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.favorite,
                  color: accentColor,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContactDialog(
      BuildContext context,
      String contactName,
      String contactNumber,
      ) {
    final Color primaryColor = Colors.black;
    final Color accentColor = const Color(0xFFFFEB3B);
    final Color cardColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Contact Details',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $contactName',
                style: TextStyle(
                  color: primaryColor.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Number: $contactNumber',
                style: TextStyle(
                  color: primaryColor.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}