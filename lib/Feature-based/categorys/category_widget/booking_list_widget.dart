import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'booking_list_controller.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingController()..fetchTodayBookings(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Today's Bookings"),
        ),
        body: Consumer<BookingController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.error.isNotEmpty) {
              return Center(child: Text(controller.error));
            }

            if (controller.bookings.isEmpty) {
              return const Center(child: Text("No bookings found."));
            }

            return ListView.builder(
              itemCount: controller.bookings.length,
              itemBuilder: (context, index) {
                final booking = controller.bookings[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("Booking ID: ${booking.readableId}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Customer ID: ${booking.customerId}"),
                        Text("Status: ${booking.bookingStatus}"),
                        Text("Date: ${booking.serviceSchedule}"),
                        Text("Amount: ₹${booking.totalBookingAmount.toStringAsFixed(2)}"),
                      ],
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
