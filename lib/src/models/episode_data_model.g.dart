// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeDataModel _$EpisodeDataModelFromJson(Map<String, dynamic> json) =>
    EpisodeDataModel(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EpisodeDataModelToJson(EpisodeDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      episodes: Episodes.fromJson(json['episodes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'episodes': instance.episodes,
    };

Episodes _$EpisodesFromJson(Map<String, dynamic> json) => Episodes(
      results: (json['results'] as List<dynamic>)
          .map((e) => SingleEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EpisodesToJson(Episodes instance) => <String, dynamic>{
      'results': instance.results,
    };

SingleEpisode _$SingleEpisodeFromJson(Map<String, dynamic> json) =>
    SingleEpisode(
      id: json['id'] as String,
      name: json['name'] as String,
      airDate: json['air_date'] as String,
      episode: json['episode'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$SingleEpisodeToJson(SingleEpisode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'created': instance.created.toIso8601String(),
    };
