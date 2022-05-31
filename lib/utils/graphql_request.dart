
class GraphqlRequest {
  final String login = """
  mutation(\$identifier: String!, \$password: String!) {
  login(input: { identifier: \$identifier, password: \$password }) {
    jwt
    user {
      email
    }
  }
}
  """;

  final String me = """
  query {
  me {
    email,
    role{name}
  }
}
  """;




}
