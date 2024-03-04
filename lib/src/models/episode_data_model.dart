import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode_data_model.g.dart';

@JsonSerializable()
class EpisodeDataModel {
  @JsonKey(name: "data")
  final Data data;

  EpisodeDataModel({
    required this.data,
  });

  factory EpisodeDataModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeDataModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "episodes")
  final Episodes episodes;

  Data({
    required this.episodes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Episodes {
  @JsonKey(name: "results")
  final List<SingleEpisode> results;

  Episodes({
    required this.results,
  });

  factory Episodes.fromJson(Map<String, dynamic> json) =>
      _$EpisodesFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodesToJson(this);
}

@JsonSerializable()
class SingleEpisode {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "air_date")
  final String airDate;
  @JsonKey(name: "episode")
  final String episode;
  @JsonKey(name: "created")
  final DateTime created;

  SingleEpisode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.created,
  });

  factory SingleEpisode.fromJson(Map<String, dynamic> json) =>
      _$SingleEpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$SingleEpisodeToJson(this);
}
