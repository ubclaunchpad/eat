//
//  YelpAPIRouter.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-24.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Alamofire

internal enum YelpAPIRouter: APIConfiguration {
  case restaurants(searchQuery: SearchQuery)
  case reviews(restaurantID: String)

  var method: HTTPMethod {
    switch self {
    case .restaurants:
      return .get
    case .reviews:
      return .get
    }
  }

  var baseURL: URL {
    let urlString: String
    switch YelpAPIManager.environment {
    case .staging:
      urlString = "https://api.yelp.com/v3/businesses/"
    case .production:
      urlString = "https://api.yelp.com/v3/businesses/"
    }
    return URL(string: urlString)!
  }

  var fullURL: URL {
    switch self {
    case .restaurants(let searchQuery):
      var queryItems = [
        URLQueryItem(name: "latitude", value: String(searchQuery.latitude)),
        URLQueryItem(name: "longitude", value: String(searchQuery.longitude)),
        URLQueryItem(name: "radius", value: String(searchQuery.radius)),
        URLQueryItem(name: "price", value: searchQuery.priceString),
        URLQueryItem(name: "limit", value: String(searchQuery.numberOfRestaurants))
      ]

      // Declare the additonal filters for the query
      switch searchQuery.mealTime {
      case .now:
        queryItems.append(URLQueryItem(name: "open_now", value: "true"))
      case .later(let date):
        queryItems.append(URLQueryItem(name: "open_at", value: String(Int(date.timeIntervalSince1970))))
      }

      if searchQuery.dietary != .none {
        queryItems.append(URLQueryItem(name: "categories", value: searchQuery.dietary.keyword))
      }

      if !searchQuery.searchTerm.isEmpty {
        queryItems.append(URLQueryItem(name: "term", value: searchQuery.searchTerm))
      }

      guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent("search"), resolvingAgainstBaseURL: true) else {
        fatalError("Failed to make URL Component")
      }

      // Adds the additional paramaters onto the query string
      urlComponents.queryItems = queryItems

      // Gets the URL string from the object
      guard let resultPath = urlComponents.url else {
        fatalError("Failed to make path from URL Component")
      }

      return resultPath
    case .reviews(let id):
      return baseURL.appendingPathComponent("\(id)/reviews")
    }
  }

  var parameters: Parameters? {
    return nil
  }

  func asURLRequest() throws -> URLRequest {
    var urlRequest = URLRequest(url: fullURL)
    urlRequest.httpMethod = method.rawValue

    urlRequest.addValue("Bearer \(APIKeys.yelp)", forHTTPHeaderField: "Authorization")

    let encoding = JSONEncoding.default
    return try encoding.encode(urlRequest, with: parameters)
  }
}
