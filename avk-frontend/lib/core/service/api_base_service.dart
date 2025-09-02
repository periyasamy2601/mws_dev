import 'package:avk/router/path_exporter.dart';

/// A service class for handling HTTP operations with retry functionality.
/// This class provides methods for making HTTP requests such as GET, POST, PUT, and DELETE.
/// Each request is retried automatically if a failure occurs, ensuring reliability in communication.
///
/// Example use case:
/// ```dart
/// APIBaseService apiService = APIBaseService();
/// try {
///   MetaEntity response = await apiService.httpGet('https://api.example.com/data');
/// } catch (e) {
///   // Handle error
/// }
/// ```
/// This class is ideal for interacting with a backend API while ensuring automatic retries and consistent error handling.

class APIBaseService {
  final RetryClient _client =
  RetryClient(Client()); // Client with retry capability

  /// Sends an HTTP GET request to the specified [url].
  ///
  /// Example:
  /// ```dart
  /// MetaEntity response = await apiService.httpGet('https://api.example.com/data');
  /// ```
  Future<MetaEntity> httpGet(String url,{Map<String,String>? queryParams}) async {
     Uri configuredUrl = Uri.parse(url);
    if(queryParams!=null){
      Uri uri = Uri.parse(url);
       configuredUrl = uri.replace(queryParameters: queryParams);
    }
    _logRequest('GET', configuredUrl.toString()); // Log the GET request details
    return _handleRequest(() async {
      return _client.get(configuredUrl, headers: await _getHeaders(url));
    });
  }

  /// Sends an HTTP POST request to the specified [url] with the provided [data].
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> data = {'key': 'value'};
  /// MetaEntity response = await apiService.httpPost('https://api.example.com/submit', data);
  /// ```
  Future<MetaEntity> httpPost(String url, Map<String, dynamic> data) async {
    _removeNullValues(data);
    _logRequest('POST', url, data); // Log the POST request details
    return _handleRequest(() async {
      return _client.post(
        Uri.parse(url),
        headers: await _getHeaders(url),
        body: _encodeBody(data), // Encode the body data as JSON
      );
    });
  }

  /// Sends an HTTP PUT request to the specified [url] with the provided [data].
  ///
  /// Example:
  /// ```dart
  /// Map<String, dynamic> data = {'key': 'updatedValue'};
  /// MetaEntity response = await apiService.httpPut('https://api.example.com/update', data);
  /// ```
  Future<MetaEntity> httpPut(String url, Map<String, dynamic> data) async {
    _removeNullValues(data);
    _logRequest('PUT', url, data); // Log the PUT request details
    return _handleRequest(() async {
      return _client.put(
        Uri.parse(url),
        headers: await _getHeaders(url),
        body: _encodeBody(data), // Encode the body data as JSON
      );
    });
  }

  /// Sends an HTTP DELETE request to the specified [url].
  ///
  /// Example:
  /// ```dart
  /// MetaEntity response = await apiService.httpDelete('https://api.example.com/delete/1');
  /// ```
  Future<MetaEntity> httpDelete(String url) async {
    _logRequest('DELETE', url); // Log the DELETE request details
    return _handleRequest(() async {
      return _client.delete(
        Uri.parse(url),
        headers: await _getHeaders(url),
      );
    });
  }

  /// Retrieves headers required for the HTTP requests.
  /// The headers include the `Content-Type` set to 'application/json'.
  Future<Map<String, String>> _getHeaders(String url) async {
// Initialize an empty map to store headers
    Map<String, String> headers = <String, String>{}
    // Add 'Content-Type' header with value 'application/json'
    ..putIfAbsent('Content-Type', () => 'application/json');

    // Retrieve the token from the storage provider
    final String token = GetIt.instance<LocalStorage>().getToken();
    // Add 'Authorization' header with token value
    headers.putIfAbsent('Authorization', () => token);

    /// - set this Header only for the Verify OTP API
    /// - otherwise no need to send this data to the API
    // if (true) {
      // Initialize device information plugin
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      // Declare variables to store device information
      late String manufacturer;
      late String model;
      // Retrieve device information for Android and iOS platforms
      if (kIsWeb) {
        // Retrieve web browser information
        final WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        manufacturer = webInfo.platform!;
        model = webInfo.vendor!;
      }else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        manufacturer = androidInfo.manufacturer;
        model = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        manufacturer = iosInfo.model;
        model = iosInfo.name;
      }
      // Get the current date time
      DateTime now = DateTime.now();

      // Get the time zone offset
      Duration offset = now.timeZoneOffset;

      // Format the offset to the desired format like "+05:30"
      String timeZone = offset.isNegative
          ? '-${offset.inHours.abs().toString().padLeft(2, '0')}:${(offset.inMinutes % 60).abs().toString().padLeft(2, '0')}'
          : '+${offset.inHours.toString().padLeft(2, '0')}:${(offset.inMinutes % 60).toString().padLeft(2, '0')}';

      // Retrieve the FCM Token from the storage provider
      // final fcmToken = StorageProvider().getFCMToken() ?? '';

      headers
        // ..putIfAbsent('X-WMS-PUSH-TOKEN', () => fcmToken)
      ..putIfAbsent('X-WMS-MODEL', () => model)
      ..putIfAbsent('X-WMS-MANUFACTURE', () => manufacturer)
      // ..putIfAbsent('X-WMS-OS_TYPE', () => manufacturer)
      // ..putIfAbsent('X-WMS-OS_VERSION', () => manufacturer)
      // ..putIfAbsent('X-WMS-PLATFORM', () => manufacturer)
      ..putIfAbsent('X-WMS-TIME-ZONE', () => timeZone);
    // }
    return headers;
  }
  /// Encodes the [data] into a JSON string, removing null or empty values from the map.
  /// This ensures that only valid data is sent in the body of the request.
  String? _encodeBody(Map<String, dynamic> data) {
    _removeNullValues(data); // Remove null or empty values from the data
    return data.isNotEmpty
        ? jsonEncode(data)
        : null; // Return the encoded JSON string
  }

  /// Recursively removes null and empty values from a map or list.
  /// This ensures that no unnecessary null or empty fields are sent in the request.
  void _removeNullValues(Map<String, dynamic> data) {
    data..removeWhere(
            (String key, value) => value == null || (value is Map && value.isEmpty))

    ..forEach((String key, value) {
      if (value is Map<String, dynamic>) {
        _removeNullValues(value);
      } else if (value is List) {
        value.removeWhere(
                (item) => item == null || (item is Map && item.isEmpty));
        for (var item in value) {
          if (item is Map<String, dynamic>) {
            _removeNullValues(item);
          }
        }
      }
    });
  }

  /// Logs the details of the HTTP request, including the method (GET, POST, etc.), URL,
  /// and any data sent with the request.
  void _logRequest(String method, String url, [Map<String, dynamic>? data]) {
    logger.debugLog('$method Url', url);
    if (data != null && data.isNotEmpty) {
      logger.debugLog('Payload', jsonEncode(data));
    }
  }

  /// Handles the HTTP request by making the actual request and processing the response.
  /// If an error occurs, it processes the exception and rethrows it.
  Future<MetaEntity> _handleRequest(Future<Response> Function() request) async {
    try {
      final Response response = await request(); // Perform the HTTP request
      if (response.statusCode == 401) {
        /// For Delete The Login User Data & Token
        await GetIt.I<LocalStorage>().clearUserDataForLogout();
        MWSnackBar()
        /// Show snack Bar
        .showSnackBar('Your token is expired please login again');

        /// navigate to login Page
        await  GetIt.I<RouteHelper>().pushReplacementAllNamed(routerKeys.login);
        throw Exception('Token Expired');
      }else if (response.statusCode == 403) {
        /// navigate to access denied Page
        await  GetIt.I<RouteHelper>().pushReplacementAllNamed(routerKeys.accessDenied);
        throw Exception('Access Denied');
      } else {
        if (response.statusCode == 429) {
          /// Show snack Bar
          MWSnackBar().showSnackBar(
              'You are reached the maximum number of requests allowed. Please wait and try again later');
        }
        MetaEntity responseData =
        MetaEntity.fromJson(jsonDecode(response.body)) // Parse the response
        ..statusCode = response.statusCode; // Attach the status code
        return responseData;
      }
    } catch (e) {
      _handleException(e); // Handle any exceptions that occur
      rethrow; // Re-throw the exception so the caller can handle it
    }
  }

  /// Processes exceptions and provides user-friendly error messages.
  /// If the exception relates to network issues, a specific error message is thrown.
  void _handleException(Object e) {
    logger.errorLog(
        '********** EXCEPTION ********* \n$e\n'); // Log the exception details
    final String errorMessage = e.toString().toLowerCase();
    if (errorMessage.contains('failed host lookup') ||
        errorMessage.contains('no address associated with hostname') ||
        errorMessage.contains('network is unreachable')) {
      throw Exception('Check Your Internet Connection'); // Network error
    } else {
      throw Exception('An error occurred: $e'); // General error
    }
  }
}
