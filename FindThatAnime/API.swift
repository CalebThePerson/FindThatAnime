// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class QueryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Query($id: Int!) {
      Media(id: $id) {
        __typename
        title {
          __typename
          english
          native
        }
        startDate {
          __typename
          year
          month
          day
        }
        endDate {
          __typename
          year
          month
          day
        }
        description(asHtml: false)
        genres
        popularity
        siteUrl
        idMal
        coverImage {
          __typename
          medium
          large
          extraLarge
        }
      }
    }
    """

  public let operationName: String = "Query"

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("Media", arguments: ["id": GraphQLVariable("id")], type: .object(Medium.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(media: Medium? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "Media": media.flatMap { (value: Medium) -> ResultMap in value.resultMap }])
    }

    /// Media query
    public var media: Medium? {
      get {
        return (resultMap["Media"] as? ResultMap).flatMap { Medium(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Media")
      }
    }

    public struct Medium: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Media"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("title", type: .object(Title.selections)),
          GraphQLField("startDate", type: .object(StartDate.selections)),
          GraphQLField("endDate", type: .object(EndDate.selections)),
          GraphQLField("description", arguments: ["asHtml": false], type: .scalar(String.self)),
          GraphQLField("genres", type: .list(.scalar(String.self))),
          GraphQLField("popularity", type: .scalar(Int.self)),
          GraphQLField("siteUrl", type: .scalar(String.self)),
          GraphQLField("idMal", type: .scalar(Int.self)),
          GraphQLField("coverImage", type: .object(CoverImage.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: Title? = nil, startDate: StartDate? = nil, endDate: EndDate? = nil, description: String? = nil, genres: [String?]? = nil, popularity: Int? = nil, siteUrl: String? = nil, idMal: Int? = nil, coverImage: CoverImage? = nil) {
        self.init(unsafeResultMap: ["__typename": "Media", "title": title.flatMap { (value: Title) -> ResultMap in value.resultMap }, "startDate": startDate.flatMap { (value: StartDate) -> ResultMap in value.resultMap }, "endDate": endDate.flatMap { (value: EndDate) -> ResultMap in value.resultMap }, "description": description, "genres": genres, "popularity": popularity, "siteUrl": siteUrl, "idMal": idMal, "coverImage": coverImage.flatMap { (value: CoverImage) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The official titles of the media in various languages
      public var title: Title? {
        get {
          return (resultMap["title"] as? ResultMap).flatMap { Title(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "title")
        }
      }

      /// The first official release date of the media
      public var startDate: StartDate? {
        get {
          return (resultMap["startDate"] as? ResultMap).flatMap { StartDate(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "startDate")
        }
      }

      /// The last official release date of the media
      public var endDate: EndDate? {
        get {
          return (resultMap["endDate"] as? ResultMap).flatMap { EndDate(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "endDate")
        }
      }

      /// Short description of the media's story and characters
      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// The genres of the media
      public var genres: [String?]? {
        get {
          return resultMap["genres"] as? [String?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "genres")
        }
      }

      /// The number of users with the media on their list
      public var popularity: Int? {
        get {
          return resultMap["popularity"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "popularity")
        }
      }

      /// The url for the media page on the AniList website
      public var siteUrl: String? {
        get {
          return resultMap["siteUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "siteUrl")
        }
      }

      /// The mal id of the media
      public var idMal: Int? {
        get {
          return resultMap["idMal"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "idMal")
        }
      }

      /// The cover images of the media
      public var coverImage: CoverImage? {
        get {
          return (resultMap["coverImage"] as? ResultMap).flatMap { CoverImage(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "coverImage")
        }
      }

      public struct Title: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["MediaTitle"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("english", type: .scalar(String.self)),
            GraphQLField("native", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(english: String? = nil, native: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "MediaTitle", "english": english, "native": native])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The official english title
        public var english: String? {
          get {
            return resultMap["english"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "english")
          }
        }

        /// Official title in it's native language
        public var native: String? {
          get {
            return resultMap["native"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "native")
          }
        }
      }

      public struct StartDate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FuzzyDate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("year", type: .scalar(Int.self)),
            GraphQLField("month", type: .scalar(Int.self)),
            GraphQLField("day", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(year: Int? = nil, month: Int? = nil, day: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "FuzzyDate", "year": year, "month": month, "day": day])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Numeric Year (2017)
        public var year: Int? {
          get {
            return resultMap["year"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "year")
          }
        }

        /// Numeric Month (3)
        public var month: Int? {
          get {
            return resultMap["month"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "month")
          }
        }

        /// Numeric Day (24)
        public var day: Int? {
          get {
            return resultMap["day"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "day")
          }
        }
      }

      public struct EndDate: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["FuzzyDate"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("year", type: .scalar(Int.self)),
            GraphQLField("month", type: .scalar(Int.self)),
            GraphQLField("day", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(year: Int? = nil, month: Int? = nil, day: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "FuzzyDate", "year": year, "month": month, "day": day])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// Numeric Year (2017)
        public var year: Int? {
          get {
            return resultMap["year"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "year")
          }
        }

        /// Numeric Month (3)
        public var month: Int? {
          get {
            return resultMap["month"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "month")
          }
        }

        /// Numeric Day (24)
        public var day: Int? {
          get {
            return resultMap["day"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "day")
          }
        }
      }

      public struct CoverImage: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["MediaCoverImage"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("medium", type: .scalar(String.self)),
            GraphQLField("large", type: .scalar(String.self)),
            GraphQLField("extraLarge", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(medium: String? = nil, large: String? = nil, extraLarge: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "MediaCoverImage", "medium": medium, "large": large, "extraLarge": extraLarge])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The cover image url of the media at medium size
        public var medium: String? {
          get {
            return resultMap["medium"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "medium")
          }
        }

        /// The cover image url of the media at a large size
        public var large: String? {
          get {
            return resultMap["large"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "large")
          }
        }

        /// The cover image url of the media at its largest size. If this size isn't available, large will be provided instead.
        public var extraLarge: String? {
          get {
            return resultMap["extraLarge"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "extraLarge")
          }
        }
      }
    }
  }
}
