//
//  ViewController.swift
//  reactorKit2
//
//  Created by 23ji on 8/24/25.
//

import ReactorKit
import RxSwift

import UIKit

class ViewController: UIViewController, View {
  
  // MARK: Properties
  
  var disposeBag = DisposeBag()
  
  let label = UILabel()

  
  // MARK: View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    label.text = "ddd"
    label.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(label)
    
    NSLayoutConstraint.activate([
      label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])
  }
  
  
  // MARK: Bind
  
  func bind(reactor: ViewReactor) {
    reactor.action.onNext(.initialize)
    
    reactor.state.map { $0.temp }
      .subscribe(onNext: { temp in
        self.label.text = temp
        print(temp)
      })
      .disposed(by: self.disposeBag)
    
    reactor.state.map { $0.isintialized }
      .subscribe(onNext: { isInitialized in
        print(isInitialized)
      })
      .disposed(by: self.disposeBag)
  }
}


