import 'dart:convert';

import 'package:http/http.dart' as http;

const String artothekBaseUrl = 'http://localhost:5050';
const String recommendationsBaseUrl = 'http://localhost:6000';

class ArtothekClient {
  ArtothekClient._(); // man kann den Kostruktor nur in der Datei erstellen.
                      // man darf keine extern Instanz von Klasse erstellen

  static ArtothekClient? _instance;

  static ArtothekClient get instance => _instance ??= ArtothekClient._(); // wenn instance null wird der interner Konstuktor aufgerufen
// Future asynchrone methode in Flutter
  Future<List<Artwork>> listArtworks({int page = 1}) async {
    final response =
        await http.get(Uri.parse('$artothekBaseUrl/artwork?page=$page'));

    final json = jsonDecode(response.body);

    final artworkResponse = ArtworkResponse.fromJson(json);//factory methode erzeugt artworkRespose object
    return artworkResponse.data;
  }

  Future<List<Artwork>> getFavorites({int userId = 101}) async {
    final response =
        await http.get(Uri.parse('$artothekBaseUrl/favorite/$userId'));

    final json = jsonDecode(response.body); // string to json
    final list = json as List; // map json as list

    return list.map((e) => Artwork.fromJson(e)).toList();
  }

  Future<void> addToFavorites(int artworkId, {int userId = 101}) {
    return http.post(
      Uri.parse('$artothekBaseUrl/favorite/new'),
      body: '{"userid": $userId,"artworkid": $artworkId}',
    );
  }

  Future<List<Artwork>> getUserRecommendations({int userId = 101}) async {
    final response = await http
        .get(Uri.parse('$recommendationsBaseUrl/recommendations/user/$userId'));

    final json = jsonDecode(response.body);

    final recommendationResponse = RecommendationsResponse.fromJson(json);

    return await Future.wait(
      recommendationResponse.recommendations.map(
        (e) => getArtwork(int.parse(e.artworkid)),
      ),
    );
  }

  Future<Artwork> getArtwork(int id) async {
    final response = await http.get(Uri.parse('$artothekBaseUrl/artwork/$id'));
    try {
      final json = jsonDecode(response.body);
      final item = (json as List).first;
      return Artwork.fromJson(item);
    } catch(e) {
      rethrow;
    }

  }
}

class ArtworkResponse {
  final List<Artwork> data;

  ArtworkResponse._(this.data);
  //json to objects
  factory ArtworkResponse.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List;
    final artworks = list.map((e) => Artwork.fromJson(e)).toList();

    return ArtworkResponse._(artworks);
  }
}

class Artwork {
  final int id;
  final String title;
  final String artist;
  final String primaryimage;

  Artwork._(this.id, this.title, this.artist, this.primaryimage);

  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork._(
        json['artworkid'], json['title'], json['artist'], json['primaryimage']);
  }
}

class RecommendationsResponse {
  final String userId;
  final List<Recommendation> recommendations;

  RecommendationsResponse(this.userId, this.recommendations);

  factory RecommendationsResponse.fromJson(Map<String, dynamic> json) {
    final recommendations = (json['recommendations'] as List)
        .map((e) => Recommendation.fromJson(e))
        .toList();
    return RecommendationsResponse(json['userId'], recommendations);
  }
}

class Recommendation {
  final String artworkid;

  Recommendation(this.artworkid);

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(json['artworkid']);
  }
}
