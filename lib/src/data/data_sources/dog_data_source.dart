import 'dart:convert';

import 'package:http/http.dart' as http;

/// A class responsible for fetching data related to dog breeds from the Dog CEO API.
class DogDataSource {
  late final http.Client _client;
  static const _baseUrl = 'https://dog.ceo/api';

  /// Constructor for the DogDataSource class.
  ///
  /// [client] is an optional parameter of type [http.Client] used for making HTTP requests.
  /// If not provided, a new [http.Client] will be instantiated.
  DogDataSource({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches a list of all dog breeds available.
  ///
  /// Returns a [Map<String, dynamic>] containing a list of all dog breeds on success, otherwise returns null.
  Future<Map<String, dynamic>?> listAllBreeds() async {
    const url = '$_baseUrl/breeds/list/all';
    final bodyJson = await _getBodyJson(url);

    return bodyJson?['message'];
  }

  /// Fetches images of a specific [breed].
  ///
  /// [breed] is a [String] representing the breed of the dog for which images are to be fetched.
  ///
  /// Returns a [List<String>] containing URLs of images for the specified breed on success, otherwise returns null.
  Future<List<String>?> getImages(String breed) async {
    final url = '$_baseUrl/breed/$breed/images';
    final bodyJson = await _getBodyJson(url);

    return (bodyJson?['message'] as List?)?.map((e) => e.toString()).toList();
  }

  /// Internal method to fetch and decode JSON from the given [url].
  ///
  /// [url] is a [String] representing the URL for the API request.
  ///
  /// Returns a [Map<String, dynamic>] containing the decoded JSON response on success, otherwise returns null.
  Future<Map<String, dynamic>?> _getBodyJson(String url) async {
    final response = await _client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return null;
    }

    late final Map<String, dynamic> bodyJson;
    try {
      bodyJson = jsonDecode(response.body);
    } catch (e) {
      return null;
    }

    if (bodyJson['status'] != 'success') {
      return null;
    }

    return bodyJson;
  }
}
