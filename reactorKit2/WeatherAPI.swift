//
//  WeatherAPI.swift
//  reactorKit2
//
//  Created by 23ji on 9/7/25.
//

import Moya

import Foundation

enum WeatherAPI {
  case weather(cityName: String)
}

extension WeatherAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.openweathermap.org")!
  }
  
  var path: String {
    switch self {
    case .weather:
      return "/data/2.5/weather"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .weather:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case let .weather(cityName):
      let parameters: [String: Any] = [
        "q": cityName,
        "appid": "e61267c07543e45b46ba83f54ac8fb03",
        "units": "metric"
      ]
      return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
}

