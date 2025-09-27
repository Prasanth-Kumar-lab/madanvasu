import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madhanvasu_app/Feature-based/property_details/property_details.dart';
// import 'package:real_estate/aswini_screens/property_details.dart';

class MyListingsScreen extends StatelessWidget {
  const MyListingsScreen({super.key});

  final Color borderColor = const Color(0xFFe4b201);
  final Color accentColor = const Color(0xFFe57c42);

  final List<Map<String, String>> properties = const [
    {
      'title': 'Modern Villa',
      'location': 'Banjara Hills, Hyderabad',
      'price': '₹2.5 Cr',
    },
    {
      'title': 'Premium Apartment',
      'location': 'Kondapur, Hyderabad',
      'price': '₹85 L',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posted Properties', style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFFe57c42)),
        elevation: 1,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFFFDE7),
      body: ListView.builder(
        itemCount: properties.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final property = properties[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PropertyDetailsScreen(
                    id:property['id']!,
                    propertyName: property['title']!,
                    location: property['location']!,
                    price: property['price']!,
                    description: property['description']!,

                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: borderColor, width: 1.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: borderColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                       Icon(Icons.location_on, size: 18, color: accentColor),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          property['location']!,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Price: ${property['price']}',
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
