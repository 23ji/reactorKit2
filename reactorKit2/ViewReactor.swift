//
//  ViewReactor.swift
//  reactorKit2
//
//  Created by 23ji on 8/24/25.
//

import ReactorKit

import Foundation

class ViewReactor: Reactor {
  // represent user actions
  enum Action {
    case initialize
  }

  // represent state changes
  enum Mutation {
    case setIsInitialized(Bool)
    case setTemp(Weather?)
  }

  // represents the current view state
  struct State {
    var isintialized: Bool
    var temp: String?
  }
  
  let initialState: State = State(
    isintialized: false
  )
  
  let weatherRepository: WeatherRepository
  
  init(weatherRepository: WeatherRepository) {
    self.weatherRepository = weatherRepository
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .initialize:
      return .concat([
        .just(.setIsInitialized(true)), //2
        self.fetchWeather(),
        .just(.setIsInitialized(false))  //3
      ])
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    
    switch mutation {
    case let .setIsInitialized(isInitialized):
      newState.isintialized = isInitialized
      
    case let .setTemp(weather):
      if let weather = weather {
        newState.temp = "\(Int(weather.main.temp))°C" 
      }
      
//      print(temp?.name)
//      print(temp?.weatherArray.first?.id)
      
//      print(temp.wind.speed)
//      print(temp.main.temp)
//      print(temp.weatherDataArray.first?.id)
    }
    
    return newState
  }
  
  private func fetchWeather() -> Observable<Mutation> {
    return self.weatherRepository.fetchWeather(cityName: "seoul")
      .asObservable()
      .map(Mutation.setTemp)
  }
}
