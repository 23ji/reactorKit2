//
//  WeatherRepository.swift
//  reactorKit2
//
//  Created by 23ji on 9/7/25.
//

import Moya
import RxMoya
import RxSwift

import Foundation

protocol WeatherRepository { //Interface
  func fetchWeather(cityName: String) -> Single<Double?>
}

class WeatherRepositoryImpl: WeatherRepository { //Implement
  let provider = MoyaProvider<WeatherAPI>()
  
  func fetchWeather(cityName: String) -> Single<Double?> {
   return provider.rx.request(.weather(cityName: cityName))
      .mapJSON()
      .map { $0 as? [String: Any]}
      .map { $0?["main"] as? [String: Any]}
      .map { $0?["temp"] as? Double}
  }
}
