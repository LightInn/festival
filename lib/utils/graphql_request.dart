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

  final String publicData = """
query GetFestivalsNotFinished {
  festivals(filters: { date_end: { gte: "2022-05-04" } }) {
    data {
      attributes {
        name,
        date_start,
        date_end,
        localisation,
        stands {
          data {
            attributes {
              name

              passages {
                data {
                  attributes {
                    artist {
                      data {
                        attributes {
                          name
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}

  """;
}
