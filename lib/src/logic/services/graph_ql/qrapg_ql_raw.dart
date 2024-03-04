class GraphQlRaw {
  static const String getEpisodeQuery = """
    query Episode {
    episodes {
        results {
            id
            name
            air_date
            episode
            created
        }
    }
  }
  """;
}
