// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import 'Booking_list_modle.dart';
//
// // APIiiiiiiiiiiiiiiiiiiiii Service
//
// class BookingService {
//   static const String _baseUrl = 'https://madadservices.com/api/v1/serviceman/booking/list';
//
//   Future<BookingResponse> fetchBookings({
//     required String token,
//     int limit = 100,
//     int offset = 1,
//     String bookingStatus = 'pending',
//     String slot = '5am to 9am',
//     String serviceId = '10646e61-1a40-4b4f-a388-2ae804e2e301',
//     String fromDate = '01-07-2025',
//     String toDate = '01-07-2025',
//   }) async {
//     final uri = Uri.parse(_baseUrl).replace(queryParameters: {
//       'limit': limit.toString(),
//       'offset': offset.toString(),
//       'booking_status': bookingStatus,
//       'slot': slot,
//       'service_id': serviceId,
//       'from_date': fromDate,
//       'to_date': toDate,
//     });
//
//     final headers = {
//       'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NWZhYWFjNi1jMWQyLTRkNGMtYmViMS0wNDE5NmRkMmZhOGUiLCJqdGkiOiJmZDU2OTljZTIwOGVhNTQyOGVkMmYxZjExYmZhZDk4ZDg2Y2NlZGFlNjI3Mzc0ZWNiYzE0OGJlY2NkODliNzJiYzMyOTkwMDlkZTUwNzEyNiIsImlhdCI6MTc1NDAzMjY5MS4yODYxMDk5MjQzMTY0MDYyNSwibmJmIjoxNzU0MDMyNjkxLjI4NjExMjA3MDA4MzYxODE2NDA2MjUsImV4cCI6MTc4NTU2ODY5MS4yODE3Mjk5MzY1OTk3MzE0NDUzMTI1LCJzdWIiOiIyNDAxNmRlNi03OTFjLTQxYTgtYTczMS03N2I1NGRlYWZlYTciLCJzY29wZXMiOltdfQ.nkuSqkKCbm-guZsueTRxSS9rQOYuRWq7b63iqp5Ol6K9Elq13LKmFQrEVs8BYRrB4F6OxdGQr7hh-FHBF8kL1LmJpBT1MkOtv9N46WpcFmi7oLTVUg048f6UW61l43cjwjtzPp7ZrRmgGOaxx_bTeWEDc5jvlMuN__8Fc3ENnxiO8oZoxuWxLq0rId6t1w0oLH2AI_kmRBVCJtjzml3m5f1hcOn1lRsKbdykmw-dhUZbjckOQHO8Z-nKhCXGfAwK7uG27NtOUkVss2YLwdOIQnpnzixcAOsWZ--zO773QYQF_878p0zB7nq5bcFr3P2_PZBLK6-iZS69YtIzNFeDoecpNR3og1MlCFULnIZO9j9w88iGisjaVDW9z_6nj7F5jmq_eayXDawkdz6k7nfgn9Zl4Dz3uTcxggNlDBZpECXienYhnnoz7JdB2sExfu2A0IDQYeKL6Pugvm083Motp-HN2tWQ038EHvv67S2nRiMIlbSqxJohAtf-SwNR_nIPcpU5J8dbmA4SYJ5OzKooRCqAEXH2FwR72qFzQKBSqwX0bgTesVD-jdnt5zS1VgUtDPU-LxFrtFrKOPl8C7pnlk9n12447MWsNw3-EdfwuejvPim-EGtqHV5YCqyvb-0O54-6gVe9ovnTWWlgMSb6RjN5Y_60uM-yxJWM2grYUMU',
//       'Content-Type': 'application/json',
//     };
//
//     try {
//       final response = await http.get(uri, headers: headers);
//
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);
//         return BookingResponse.fromJson(jsonData);
//       } else {
//         throw Exception('Failed to load bookings: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching bookings: $e');
//     }
//   }
// }
//
// // Controllerrrrrrrrrrrrrrrrrrrrrrrrrrrr
// class BookingController with ChangeNotifier {
//   final BookingService _bookingService = BookingService();
//   BookingResponse? bookingResponse;
//   bool isLoading = false;
//   String? errorMessage;
//
//   Future<void> fetchBookings({
//     required String token,
//     int limit = 100,
//     int offset = 1,
//     String bookingStatus = 'pending',
//     String slot = '5am to 9am',
//     String serviceId = '10646e61-1a40-4b4f-a388-2ae804e2e301',
//     String fromDate = '01-07-2025',
//     String toDate = '01-07-2025',
//   }) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();
//
//     try {
//       bookingResponse = await _bookingService.fetchBookings(
//         token: token,
//         limit: limit,
//         offset: offset,
//         bookingStatus: bookingStatus,
//         slot: slot,
//         serviceId: serviceId,
//         fromDate: fromDate,
//         toDate: toDate,
//       );
//     } catch (e) {
//       errorMessage = e.toString();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
//
// // UIiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii Screen
// class BookingScreen extends StatefulWidget {
//   final String token;
//
//   const BookingScreen({Key? key, required this.token}) : super(key: key);
//
//   @override
//   _BookingScreenState createState() => _BookingScreenState();
// }
//
// class _BookingScreenState extends State<BookingScreen> {
//   late BookingController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = BookingController();
//     _controller.fetchBookings(token: widget.token);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bookings'),
//         backgroundColor: Colors.blue,
//       ),
//       body: ChangeNotifierProvider<BookingController>.value(
//         value: _controller,
//         child: Consumer<BookingController>(
//           builder: (context, controller, child) {
//             if (controller.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//
//             if (controller.errorMessage != null) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       controller.errorMessage!,
//                       style: const TextStyle(color: Colors.red),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () => controller.fetchBookings(token: widget.token),
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             if (controller.bookingResponse?.content?.bookings?.isEmpty ?? true) {
//               return const Center(child: Text('No bookings found'));
//             }
//
//             return ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: controller.bookingResponse!.content!.bookings!.length,
//               itemBuilder: (context, index) {
//                 final booking = controller.bookingResponse!.content!.bookings![index];
//                 return BookingCard(booking: booking);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // Booking Card Widget
// class BookingCard extends StatelessWidget {
//   final Booking booking;
//
//   const BookingCard({Key? key, required this.booking}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final dateFormat = DateFormat('MMM dd, yyyy HH:mm');
//     String scheduleText = 'N/A';
//     if (booking.serviceSchedule != null) {
//       try {
//         final schedule = DateTime.parse(booking.serviceSchedule!);
//         scheduleText = dateFormat.format(schedule);
//       } catch (e) {
//         scheduleText = 'Invalid date';
//       }
//     }
//
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Booking #${booking.readableId ?? 'N/A'}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blue,
//                   ),
//                 ),
//                 Chip(
//                   label: Text(
//                     (booking.bookingStatus ?? 'unknown').toUpperCase(),
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   backgroundColor: (booking.bookingStatus ?? '').toLowerCase() == 'accepted'
//                       ? Colors.green
//                       : Colors.orange,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Text(
//               'Service: ${booking.subCategory?.name ?? 'N/A'}',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Schedule: $scheduleText',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Slot: ${booking.slot ?? 'N/A'}',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Amount: \$${booking.totalBookingAmount?.toStringAsFixed(2) ?? '0.00'}',
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Address: ${booking.serviceAddressLocation?.address ?? 'N/A'}',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Vehicle: ${booking.vehicle != null ? '${booking.vehicle!.brand ?? 'N/A'} ${booking.vehicle!.model ?? 'N/A'} (${booking.vehicle!.vehicleNo ?? 'N/A'})' : 'N/A'}',
//               style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('View details clicked')),
//                     );
//                   },
//                   child: const Text('View Details'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
