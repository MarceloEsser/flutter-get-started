import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

const String baseUrl = "https://demo0069341.mockable.io";

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 10),
);
