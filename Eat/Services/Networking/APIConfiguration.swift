//
//  APIConfiguration.swift
//  Eat
//
//  Created by Milton Leung on 2018-06-24.
//  Copyright © 2018 launchpad. All rights reserved.
//

import Alamofire

protocol APIConfiguration: URLRequestConvertible {
  var method: HTTPMethod { get }
  var fullURL: URL { get }
  var parameters: Parameters? { get }
}

