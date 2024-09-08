// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      title: json['title'] as String?,
      trailing: json['trailing'] == null
          ? null
          : Trailing.fromJson(json['trailing'] as Map<String, dynamic>),
      viewType: $enumDecodeNullable(_$ViewTypeEnumMap, json['viewType']),
      contents: Section._castContentsToMap(json['contents']),
      strapline: json['strapline'] as String?,
    );

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'title': instance.title,
      'trailing': instance.trailing,
      'strapline': instance.strapline,
      'viewType': _$ViewTypeEnumMap[instance.viewType],
      'contents': instance.contents,
    };

const _$ViewTypeEnumMap = {
  ViewType.column: 'COLUMN',
  ViewType.row: 'ROW',
  ViewType.singleColumn: 'SINGLE_COLUMN',
};

Trailing _$TrailingFromJson(Map<String, dynamic> json) => Trailing(
      text: json['text'] as String?,
      playable: json['playable'] as bool?,
      endpoint: json['endpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$TrailingToJson(Trailing instance) => <String, dynamic>{
      'text': instance.text,
      'playable': instance.playable,
      'endpoint': instance.endpoint,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      explicit: json['explicit'] as bool?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      videoId: json['videoId'] as String?,
      type: $enumDecodeNullable(_$ContentTypeEnumMap, json['type']) ??
          ContentType.unknown,
      playlistId: json['playlistId'] as String?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: json['album'] == null
          ? null
          : Album.fromJson(json['album'] as Map<String, dynamic>),
      endpoint: json['endpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'thumbnails': instance.thumbnails,
      'explicit': instance.explicit,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'videoId': instance.videoId,
      'type': _$ContentTypeEnumMap[instance.type]!,
      'playlistId': instance.playlistId,
      'artists': instance.artists,
      'album': instance.album,
      'endpoint': instance.endpoint,
    };

const _$ContentTypeEnumMap = {
  ContentType.song: 'SONG',
  ContentType.video: 'VIDEO',
  ContentType.playlist: 'PLAYLIST',
  ContentType.artist: 'ARTIST',
  ContentType.album: 'ALBUM',
  ContentType.episode: 'EPISODE',
  ContentType.unknown: 'unknown',
};

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      url: json['url'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      name: json['name'] as String?,
      endpoint: json['endpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'name': instance.name,
      'endpoint': instance.endpoint,
    };

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      name: json['name'] as String?,
      endpoint: json['endpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('endpoint', instance.endpoint);
  return val;
}
