//
//  Weather.swift
//  reactorKit2
//
//  Created by 23ji on 9/14/25.
//

import ObjectMapper

import Foundation

struct Weather: ImmutableMappable {
  let name: String
  let weatherArray: [WeatherData]
  let main: Main
  
  init(map: Map) throws {
    self.name = try map.value("name")
    self.weatherArray = try map.value("weather")
    self.main = try map.value("main")
  }
}

struct WeatherData : ImmutableMappable {
  let id: Int
  
  init(map: Map) throws {
    self.id = try map.value("id")
  }
}

struct Main: ImmutableMappable {
  let temp: Double
  
  init(map: Map) throws {
    self.temp = try map.value("temp")
  }
}

// 수동의 방법
//struct Weather: Decodable {
//  let name: String
//  let wind: Wind
//  let main: Main
//  let weatherDataArray: [WeatherData]
//  let system: System
//  
//  enum CodingKeys: String, CodingKey {
//    case name
//    case wind
//    case main
//    case weatherDataArray = "weather"
//    case system = "sys"
//  }
//}
//
//struct Wind: Decodable {
//  let speed: Double
//  let deg: Double
//  let gust: Double
//}
//
//struct Main: Decodable {
//  let temp: Double
//}
//
//struct WeatherData: Decodable {
//  let id: Int
//}
//
//struct System: Decodable {
//  let country: String
//}
