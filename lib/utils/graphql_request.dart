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
      id,
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

  final String createFestival = """
mutation(
  \$name: String!
  \$date_start: Date!
  \$date_end: Date!
  \$localisation: String!
) {
  createFestival(
    data: {
      name: \$name
      date_start: \$date_start
      date_end: \$date_end
      localisation: \$localisation
    }
  ) {
    data {
      id
    }
  }
}
  """;

  final String editFestival = """
mutation(
  \$id: ID!
  \$name: String!
  \$date_start: Date!
  \$date_end: Date!
  \$localisation: String!
) {
  updateFestival(
    id: \$id
    data: {
      name: \$name
      date_start: \$date_start
      localisation: \$localisation
      date_end: \$date_end
    }
  ) {
    data {
      id
    }
  }
}

  """;

  final String deleteFestival = """
mutation(\$id: ID!) {
  deleteFestival(id: \$id) {
    data {
      id
    }
  }
}
  """;
}
