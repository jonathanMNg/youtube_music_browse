import 'package:json_annotation/json_annotation.dart';
part 'section_model.g.dart';

enum ContentType {
  @JsonValue('SONG')
  song,
  @JsonValue('VIDEO')
  video,
  @JsonValue('PLAYLIST')
  playlist,
  @JsonValue('ARTIST')
  artist,
  @JsonValue('ALBUM')
  album,
  @JsonValue('EPISODE')
  episode,
  unknown
}

enum ViewType {
  @JsonValue('COLUMN')
  column,
  @JsonValue('ROW')
  row,
  @JsonValue('SINGLE_COLUMN')
  singleColumn,
}
@JsonSerializable()
class Section {
  Section(
      {this.title,
      this.trailing,
      this.viewType,
      this.contents,
      this.strapline,
      });

  final String? title;
  final Trailing? trailing;
  final String? strapline;
  final ViewType? viewType;
  @JsonKey(fromJson: _castContentsToMap)
  final List<Content>? contents;


  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
  Map<String, dynamic> toJson() => _$SectionToJson(this);

  static List<Content> _castContentsToMap(dynamic contents) {
    final List<Map<String, dynamic>> mapContents = [];
    for(final content in contents) {
      mapContents.add(content.cast<String,dynamic>());
    }
    return mapContents.map((e) => Content.fromJson(e)).toList();
  }

}

@JsonSerializable()
class Trailing {
  Trailing(
      {this.text, this.playable, this.endpoint});
  final String? text;
  final bool? playable;
  final Map<String, dynamic>? endpoint;
  factory Trailing.fromJson(Map<String, dynamic> json) => _$TrailingFromJson(json);
  Map<String, dynamic> toJson() => _$TrailingToJson(this);
}

// @JsonSerializable()
// class Endpoint {
//   Endpoint({this.playlistId, this.params, this.browseId});
//   final String? playlistId;
//   final String? params;
//   final String? browseId;
//
//   factory Endpoint.fromJson(Map<String, dynamic> json) => _$EndpointFromJson(json);
//   Map<String, dynamic> toJson() => _$EndpointToJson(this);
// }

@JsonSerializable(includeIfNull: true)
class Content {
  Content(
      {
      required this.thumbnails,
      this.explicit,
      this.title,
      this.subtitle,
      this.videoId,
      this.type = ContentType.unknown,
      this.playlistId,
      this.artists,
      this.album,
      this.endpoint,
      });

  final List<Thumbnail> thumbnails;
  final bool? explicit;
  final String? title;
  final String? subtitle;
  final String? videoId;
  final ContentType type;
  final String? playlistId;
  final List<Artist>? artists;
  final Album? album;
  final Map<String, dynamic>? endpoint;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);
  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Thumbnail {
  Thumbnail({required this.url, required this.width, required this.height});
  final String url;
  final int width;
  final int height;
  factory Thumbnail.fromJson(Map<String, dynamic> json) => _$ThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}

@JsonSerializable()
class Artist {
  Artist({this.name, this.endpoint});
  final String? name;
  final Map<String, dynamic>? endpoint;
  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Album {
  Album({this.name, this.endpoint});
  final String? name;
  final Map<String, dynamic>? endpoint;
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
