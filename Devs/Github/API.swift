//  This file was automatically generated and should not be edited.

import Apollo

public final class SearchUsersQuery: GraphQLQuery {
  public static let operationString =
    "query SearchUsers($searchString: String!, $afterCursor: String) {" +
    "  search(query: $searchString, type: USER, first: 10, after: $afterCursor) {" +
    "    __typename" +
    "    userCount" +
    "    pageInfo {" +
    "      __typename" +
    "      ...PagePosition" +
    "    }" +
    "    edges {" +
    "      __typename" +
    "      node {" +
    "        __typename" +
    "        ...DeveloperDetails" +
    "      }" +
    "    }" +
    "  }" +
    "}"

  public static var requestString: String { return operationString.appending(PagePosition.fragmentString).appending(DeveloperDetails.fragmentString) }

  public var searchString: String
  public var afterCursor: String?

  public init(searchString: String, afterCursor: String? = nil) {
    self.searchString = searchString
    self.afterCursor = afterCursor
  }

  public var variables: GraphQLMap? {
    return ["searchString": searchString, "afterCursor": afterCursor]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["query": Variable("searchString"), "type": "USER", "first": 10, "after": Variable("afterCursor")], type: .nonNull(.object(Search.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(snapshot: snapshot["search"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("userCount", type: .nonNull(.scalar(Int.self))),
        GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.self))),
        GraphQLField("edges", type: .list(.object(Edge.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(userCount: Int, pageInfo: PageInfo, edges: [Edge?]? = nil) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "userCount": userCount, "pageInfo": pageInfo, "edges": edges])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The number of users that matched the search query.
      public var userCount: Int {
        get {
          return snapshot["userCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "userCount")
        }
      }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo {
        get {
          return PageInfo(snapshot: snapshot["pageInfo"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "pageInfo")
        }
      }

      /// A list of edges.
      public var edges: [Edge?]? {
        get {
          return (snapshot["edges"]! as! [Snapshot?]?).flatMap { $0.map { $0.flatMap { Edge(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "edges")
        }
      }

      public struct PageInfo: GraphQLSelectionSet {
        public static let possibleTypes = ["PageInfo"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("endCursor", type: .scalar(String.self)),
          GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(endCursor: String? = nil, hasNextPage: Bool) {
          self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? {
          get {
            return snapshot["endCursor"]! as! String?
          }
          set {
            snapshot.updateValue(newValue, forKey: "endCursor")
          }
        }

        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool {
          get {
            return snapshot["hasNextPage"]! as! Bool
          }
          set {
            snapshot.updateValue(newValue, forKey: "hasNextPage")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(snapshot: snapshot)
          }
          set {
            snapshot = newValue.snapshot
          }
        }

        public struct Fragments {
          public var snapshot: Snapshot

          public var pagePosition: PagePosition {
            get {
              return PagePosition(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }
        }
      }

      public struct Edge: GraphQLSelectionSet {
        public static let possibleTypes = ["SearchResultItemEdge"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("node", type: .object(Node.self)),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(node: Node? = nil) {
          self.init(snapshot: ["__typename": "SearchResultItemEdge", "node": node])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The item at the end of the edge.
        public var node: Node? {
          get {
            return (snapshot["node"]! as! Snapshot?).flatMap { Node(snapshot: $0) }
          }
          set {
            snapshot.updateValue(newValue?.snapshot, forKey: "node")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(AsUser.self),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public static func makeIssue() -> Node {
            return Node(snapshot: ["__typename": "Issue"])
          }

          public static func makePullRequest() -> Node {
            return Node(snapshot: ["__typename": "PullRequest"])
          }

          public static func makeRepository() -> Node {
            return Node(snapshot: ["__typename": "Repository"])
          }

          public static func makeUser(name: String? = nil, url: String, login: String, bio: String? = nil, email: String, location: String? = nil, avatarUrl: String, followers: AsUser.Follower, createdAt: String, isHireable: Bool) -> Node {
            return Node(snapshot: ["__typename": "User", "name": name, "url": url, "login": login, "bio": bio, "email": email, "location": location, "avatarUrl": avatarUrl, "followers": followers, "createdAt": createdAt, "isHireable": isHireable])
          }

          public static func makeOrganization() -> Node {
            return Node(snapshot: ["__typename": "Organization"])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var asUser: AsUser? {
            get {
              if !AsUser.possibleTypes.contains(__typename) { return nil }
              return AsUser(snapshot: snapshot)
            }
            set {
              guard let newValue = newValue else { return }
              snapshot = newValue.snapshot
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(snapshot: snapshot)
            }
            set {
              snapshot = newValue.snapshot
            }
          }

          public struct AsUser: GraphQLFragment {
            public static let possibleTypes = ["User"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
              GraphQLField("login", type: .nonNull(.scalar(String.self))),
              GraphQLField("bio", type: .scalar(String.self)),
              GraphQLField("email", type: .nonNull(.scalar(String.self))),
              GraphQLField("location", type: .scalar(String.self)),
              GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
              GraphQLField("followers", type: .nonNull(.object(Follower.self))),
              GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
              GraphQLField("isHireable", type: .nonNull(.scalar(Bool.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String? = nil, url: String, login: String, bio: String? = nil, email: String, location: String? = nil, avatarUrl: String, followers: Follower, createdAt: String, isHireable: Bool) {
              self.init(snapshot: ["__typename": "User", "name": name, "url": url, "login": login, "bio": bio, "email": email, "location": location, "avatarUrl": avatarUrl, "followers": followers, "createdAt": createdAt, "isHireable": isHireable])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The user's public profile name.
            public var name: String? {
              get {
                return snapshot["name"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }

            /// The HTTP URL for this user
            public var url: String {
              get {
                return snapshot["url"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "url")
              }
            }

            /// The username used to login.
            public var login: String {
              get {
                return snapshot["login"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "login")
              }
            }

            /// The user's public profile bio.
            public var bio: String? {
              get {
                return snapshot["bio"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "bio")
              }
            }

            /// The user's publicly visible profile email.
            public var email: String {
              get {
                return snapshot["email"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "email")
              }
            }

            /// The user's public profile location.
            public var location: String? {
              get {
                return snapshot["location"]! as! String?
              }
              set {
                snapshot.updateValue(newValue, forKey: "location")
              }
            }

            /// A URL pointing to the user's public avatar.
            public var avatarUrl: String {
              get {
                return snapshot["avatarUrl"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "avatarUrl")
              }
            }

            /// A list of users the given user is followed by.
            public var followers: Follower {
              get {
                return Follower(snapshot: snapshot["followers"]! as! Snapshot)
              }
              set {
                snapshot.updateValue(newValue.snapshot, forKey: "followers")
              }
            }

            /// Identifies the date and time when the object was created.
            public var createdAt: String {
              get {
                return snapshot["createdAt"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "createdAt")
              }
            }

            /// Whether or not the user has marked themselves as for hire.
            public var isHireable: Bool {
              get {
                return snapshot["isHireable"]! as! Bool
              }
              set {
                snapshot.updateValue(newValue, forKey: "isHireable")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(snapshot: snapshot)
              }
              set {
                snapshot = newValue.snapshot
              }
            }

            public struct Fragments {
              public var snapshot: Snapshot

              public var developerDetails: DeveloperDetails {
                get {
                  return DeveloperDetails(snapshot: snapshot)
                }
                set {
                  snapshot = newValue.snapshot
                }
              }
            }

            public struct Follower: GraphQLSelectionSet {
              public static let possibleTypes = ["FollowerConnection"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
              ]

              public var snapshot: Snapshot

              public init(snapshot: Snapshot) {
                self.snapshot = snapshot
              }

              public init(totalCount: Int) {
                self.init(snapshot: ["__typename": "FollowerConnection", "totalCount": totalCount])
              }

              public var __typename: String {
                get {
                  return snapshot["__typename"]! as! String
                }
                set {
                  snapshot.updateValue(newValue, forKey: "__typename")
                }
              }

              /// Identifies the total count of items in the connection.
              public var totalCount: Int {
                get {
                  return snapshot["totalCount"]! as! Int
                }
                set {
                  snapshot.updateValue(newValue, forKey: "totalCount")
                }
              }
            }
          }

          public struct Fragments {
            public var snapshot: Snapshot

            public var developerDetails: DeveloperDetails? {
              get {
                if !DeveloperDetails.possibleTypes.contains(snapshot["__typename"]! as! String) { return nil }
                return DeveloperDetails(snapshot: snapshot)
              }
              set {
                guard let newValue = newValue else { return }
                snapshot = newValue.snapshot
              }
            }
          }
        }
      }
    }
  }
}

public struct PagePosition: GraphQLFragment {
  public static let fragmentString =
    "fragment PagePosition on PageInfo {" +
    "  __typename" +
    "  endCursor" +
    "  hasNextPage" +
    "}"

  public static let possibleTypes = ["PageInfo"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("endCursor", type: .scalar(String.self)),
    GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(endCursor: String? = nil, hasNextPage: Bool) {
    self.init(snapshot: ["__typename": "PageInfo", "endCursor": endCursor, "hasNextPage": hasNextPage])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// When paginating forwards, the cursor to continue.
  public var endCursor: String? {
    get {
      return snapshot["endCursor"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "endCursor")
    }
  }

  /// When paginating forwards, are there more items?
  public var hasNextPage: Bool {
    get {
      return snapshot["hasNextPage"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "hasNextPage")
    }
  }
}

public struct DeveloperDetails: GraphQLFragment {
  public static let fragmentString =
    "fragment DeveloperDetails on User {" +
    "  __typename" +
    "  name" +
    "  url" +
    "  login" +
    "  bio" +
    "  email" +
    "  location" +
    "  avatarUrl" +
    "  followers {" +
    "    __typename" +
    "    totalCount" +
    "  }" +
    "  createdAt" +
    "  isHireable" +
    "}"

  public static let possibleTypes = ["User"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("name", type: .scalar(String.self)),
    GraphQLField("url", type: .nonNull(.scalar(String.self))),
    GraphQLField("login", type: .nonNull(.scalar(String.self))),
    GraphQLField("bio", type: .scalar(String.self)),
    GraphQLField("email", type: .nonNull(.scalar(String.self))),
    GraphQLField("location", type: .scalar(String.self)),
    GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
    GraphQLField("followers", type: .nonNull(.object(Follower.self))),
    GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
    GraphQLField("isHireable", type: .nonNull(.scalar(Bool.self))),
  ]

  public var snapshot: Snapshot

  public init(snapshot: Snapshot) {
    self.snapshot = snapshot
  }

  public init(name: String? = nil, url: String, login: String, bio: String? = nil, email: String, location: String? = nil, avatarUrl: String, followers: Follower, createdAt: String, isHireable: Bool) {
    self.init(snapshot: ["__typename": "User", "name": name, "url": url, "login": login, "bio": bio, "email": email, "location": location, "avatarUrl": avatarUrl, "followers": followers, "createdAt": createdAt, "isHireable": isHireable])
  }

  public var __typename: String {
    get {
      return snapshot["__typename"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The user's public profile name.
  public var name: String? {
    get {
      return snapshot["name"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "name")
    }
  }

  /// The HTTP URL for this user
  public var url: String {
    get {
      return snapshot["url"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "url")
    }
  }

  /// The username used to login.
  public var login: String {
    get {
      return snapshot["login"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "login")
    }
  }

  /// The user's public profile bio.
  public var bio: String? {
    get {
      return snapshot["bio"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "bio")
    }
  }

  /// The user's publicly visible profile email.
  public var email: String {
    get {
      return snapshot["email"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "email")
    }
  }

  /// The user's public profile location.
  public var location: String? {
    get {
      return snapshot["location"]! as! String?
    }
    set {
      snapshot.updateValue(newValue, forKey: "location")
    }
  }

  /// A URL pointing to the user's public avatar.
  public var avatarUrl: String {
    get {
      return snapshot["avatarUrl"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "avatarUrl")
    }
  }

  /// A list of users the given user is followed by.
  public var followers: Follower {
    get {
      return Follower(snapshot: snapshot["followers"]! as! Snapshot)
    }
    set {
      snapshot.updateValue(newValue.snapshot, forKey: "followers")
    }
  }

  /// Identifies the date and time when the object was created.
  public var createdAt: String {
    get {
      return snapshot["createdAt"]! as! String
    }
    set {
      snapshot.updateValue(newValue, forKey: "createdAt")
    }
  }

  /// Whether or not the user has marked themselves as for hire.
  public var isHireable: Bool {
    get {
      return snapshot["isHireable"]! as! Bool
    }
    set {
      snapshot.updateValue(newValue, forKey: "isHireable")
    }
  }

  public struct Follower: GraphQLSelectionSet {
    public static let possibleTypes = ["FollowerConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(totalCount: Int) {
      self.init(snapshot: ["__typename": "FollowerConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return snapshot["__typename"]! as! String
      }
      set {
        snapshot.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return snapshot["totalCount"]! as! Int
      }
      set {
        snapshot.updateValue(newValue, forKey: "totalCount")
      }
    }
  }
}