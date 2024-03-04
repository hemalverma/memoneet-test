import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infotexh_test/src/logic/services/api/api_client.dart';

class GraphQlService {
  late GraphQLClient _client;
  GraphQlService() {
    final HttpLink httpLink = HttpLink(ApiClient.graphQlClient);
    _client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.none,
          cacheReread: CacheRereadPolicy.ignoreAll,
        ),
      ),
    );
  }

  Future<QueryResult> performQuery(
    String query, {
    required Map<String, dynamic> variables,
  }) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables,
    );
    final result = await _client.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    return result;
  }
}
