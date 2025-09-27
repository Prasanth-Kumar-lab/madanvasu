import 'package:flutter/material.dart';
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_price_per_day/price_per_days_Controller.dart';
import 'package:madhanvasu_app/Feature-based/post_property_feature/property_price_per_day/price_per_days_modle.dart';

class PropertyPriceScreen extends StatefulWidget {
  @override
  _PropertyPriceScreenState createState() => _PropertyPriceScreenState();
}

class _PropertyPriceScreenState extends State<PropertyPriceScreen> {
  late Future<PropertyPricePerDay?> futurePrices;

  @override
  void initState() {
    super.initState();
    futurePrices = PropertyPriceController().fetchPropertyPrices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Prices Per Day'),
      ),
      body: FutureBuilder<PropertyPricePerDay?>(
        future: futurePrices,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('Failed to load data.'));
          } else if (snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
            return Center(child: Text('No data found.'));
          }

          final priceList = snapshot.data!.data!;

          return ListView.builder(
            itemCount: priceList.length,
            itemBuilder: (context, index) {
              final item = priceList[index];
              return ListTile(
                title: Text('ID: ${item.id}'),
                subtitle: Text('Charge: ₹${item.forDayCharge}'),
              );
            },
          );
        },
      ),
    );
  }
}
