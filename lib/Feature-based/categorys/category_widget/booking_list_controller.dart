import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'booking_display_model.dart';

class BookingController extends ChangeNotifier {
  List<BookingData> bookings = [];
  bool isLoading = false;
  String error = '';

  Future<void> fetchTodayBookings() async {
    isLoading = true;
    error = '';
    notifyListeners();

    final headers = {
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NWZhYWFjNi1jMWQyLTRkNGMtYmViMS0wNDE5NmRkMmZhOGUiLCJqdGkiOiJmZDU2OTljZTIwOGVhNTQyOGVkMmYxZjExYmZhZDk4ZDg2Y2NlZGFlNjI3Mzc0ZWNiYzE0OGJlY2NkODliNzJiYzMyOTkwMDlkZTUwNzEyNiIsImlhdCI6MTc1NDAzMjY5MS4yODYxMDk5MjQzMTY0MDYyNSwibmJmIjoxNzU0MDMyNjkxLjI4NjExMjA3MDA4MzYxODE2NDA2MjUsImV4cCI6MTc4NTU2ODY5MS4yODE3Mjk5MzY1OTk3MzE0NDUzMTI1LCJzdWIiOiIyNDAxNmRlNi03OTFjLTQxYTgtYTczMS03N2I1NGRlYWZlYTciLCJzY29wZXMiOltdfQ.nkuSqkKCbm-guZsueTRxSS9rQOYuRWq7b63iqp5Ol6K9Elq13LKmFQrEVs8BYRrB4F6OxdGQr7hh-FHBF8kL1LmJpBT1MkOtv9N46WpcFmi7oLTVUg048f6UW61l43cjwjtzPp7ZrRmgGOaxx_bTeWEDc5jvlMuN__8Fc3ENnxiO8oZoxuWxLq0rId6t1w0oLH2AI_kmRBVCJtjzml3m5f1hcOn1lRsKbdykmw-dhUZbjckOQHO8Z-nKhCXGfAwK7uG27NtOUkVss2YLwdOIQnpnzixcAOsWZ--zO773QYQF_878p0zB7nq5bcFr3P2_PZBLK6-iZS69YtIzNFeDoecpNR3og1MlCFULnIZO9j9w88iGisjaVDW9z_6nj7F5jmq_eayXDawkdz6k7nfgn9Zl4Dz3uTcxggNlDBZpECXienYhnnoz7JdB2sExfu2A0IDQYeKL6Pugvm083Motp-HN2tWQ038EHvv67S2nRiMIlbSqxJohAtf-SwNR_nIPcpU5J8dbmA4SYJ5OzKooRCqAEXH2FwR72qFzQKBSqwX0bgTesVD-jdnt5zS1VgUtDPU-LxFrtFrKOPl8C7pnlk9n12447MWsNw3-EdfwuejvPim-EGtqHV5YCqyvb-0O54-6gVe9ovnTWWlgMSb6RjN5Y_60uM-yxJWM2grYUMU'
    };

    final url = Uri.parse(
      'https://madadservices.com/api/v1/provider/booking/service/todaybookings?limit=10&offset=1&filter=pending&slot=5am to 10am',
    );

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final bookingResponse = BookingResponseModel.fromJson(jsonData);

        bookings = bookingResponse.content.bookings;
      } else {
        error = 'Failed to fetch bookings: ${response.statusCode}';
      }
    } catch (e) {
      error = 'Error: $e';
    }

    isLoading = false;
    notifyListeners();
  }
}
