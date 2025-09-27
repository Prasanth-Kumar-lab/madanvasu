import 'package:flutter/material.dart';
// import 'package:real_estate/aswini_screens/property_details.dart';
import '../../app/configuration/ themes/app_colors.dart';
import '../../Feature-based/property_details/property_details.dart';

class SavedPropertiesScreen extends StatelessWidget {

  final Color primaryColor = Colors.black;
  final Color accentColor = const Color(0xFFe57c42);
  final Color backgroundColor = const Color(0xFFFFFDE7);
  final Color cardColor = Colors.white;

  SavedPropertiesScreen({super.key});

  final List<Map<String, String>> savedProperties = [
    {
      'title': 'Luxury Apartment in Banjara Hills',
      'location': 'Banjara Hills, Hyderabad',
      'price': '₹75,000 / month',
      'type': 'Apartment',
      'area': '2200 sq.ft',
    },
    {
      'title': 'Modern Villa in Gachibowli',
      'location': 'Gachibowli, Hyderabad',
      'price': '₹1,20,000 / month',
      'type': 'Villa',
      'area': '3000 sq.ft',
    },
    {
      'title': 'Residential Plot in Madhapur',
      'location': 'Madhapur, Hyderabad',
      'price': '₹30,000 / month',
      'type': 'Land',
      'area': '2000 sq.ft',
    },
    {
      'title': 'Premium Flat in Hitech City',
      'location': 'Hitech City, Hyderabad',
      'price': '₹65,000 / month',
      'type': 'Apartment',
      'area': '1800 sq.ft',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondary.withOpacity(0.8),
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Saved Properties',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0xFFe57c42)),
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
              'No Saved Properties in Hyderabad yet!',
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
            context: context,
            title: property['title']!,
            location: property['location']!,
            price: property['price']!,
            type: property['type']!,
            area: property['area']!,
          );

        },
      ),
    );
  }

  Widget _buildSavedCard({
    required BuildContext context,
    required String title,
    required String location,
    required String price,
    required String type,
    required String area,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFe4b201),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailsScreen(
                propertyName: title,
                location: location,
                price: price, description: '',
                id:'id'!,

                // Add more params if needed
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Property details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFe4b201),
                        fontSize: 18,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 16, color: Color(0xFFe57c42)),
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
                        Icon(Icons.apartment, size: 16, color: Color(0xFFe57c42)),
                        const SizedBox(width: 4),
                        Text(
                          type,
                          style: TextStyle(
                            color: primaryColor.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.square_foot_outlined, size: 16, color: Color(0xFFe57c42)),
                        const SizedBox(width: 4),
                        Text(
                          area,
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF179a3a),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 110),
                child: Icon(Icons.favorite, color: accentColor, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
  IconData _getPropertyIcon(String type) {
    switch (type.toLowerCase()) {
      case 'villa':
        return Icons.villa;
      case 'apartment':
        return Icons.apartment;
      case 'land':
        return Icons.terrain;
      default:
        return Icons.home;
    }
  }
}