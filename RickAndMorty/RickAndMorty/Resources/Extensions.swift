//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Elizeu RS on 08/02/23.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach({
      addSubview($0)
    })
  }
}


