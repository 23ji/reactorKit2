//
//  WeatherRepository.swift
//  reactorKit2
//
//  Created by 23ji on 9/7/25.
//

import Moya
import RxMoya
import RxSwift
import ObjectMapper

import Foundation

protocol WeatherRepository { //Interface
  func fetchWeather(cityName: String) -> Single<Weather?>
}

class WeatherRepositoryImpl: WeatherRepository { //Implement
  let provider = MoyaProvider<WeatherAPI>()
  
  func fetchWeather(cityName: String) -> Single<Weather?> {
   return provider.rx.request(.weather(cityName: cityName))
      //.map(Weather.self) //수동
      .mapJSON()
      .map { json in
        return Mapper<Weather>().map(JSONObject: json)
      }
  }
}
