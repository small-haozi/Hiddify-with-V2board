// services/payment_service.dart
import 'package:hiddify/features/panel/xboard/services/http_service/http_service.dart';

class PaymentService {
  final HttpService _httpService = HttpService();

  Future<Map<String, dynamic>> submitOrder(
      String tradeNo, String method, String accessToken,) async {
    return await _httpService.postRequest(
      "/api/v1/user/order/checkout",
      {"trade_no": tradeNo, "method": method},
      headers: {'Authorization': accessToken},
    );
  }

  Future<List<dynamic>> getPaymentMethods(String accessToken) async {
    try {
      final response = await _httpService.getRequest(
        "/api/v1/user/order/getPaymentMethod",
        headers: {'Authorization': accessToken},
      );
  
      // 检查 response 是否包含 'data' 字段，并且是一个列表
      if (response.containsKey('data') && response['data'] is List) {
        return (response['data'] as List).cast<dynamic>();
      } else {
        throw Exception('Invalid response format: ${response.toString()}');
      }
    } catch (e) {
      // 捕获异常并打印错误信息
      print('Error fetching payment methods: $e');
      rethrow; // 重新抛出异常以便上层处理
    }
  }
}
