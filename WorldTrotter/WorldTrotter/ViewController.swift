//
//  ViewController.swift
//  WorldTrotter
//
//  Created by Hoff Henry Pereira da Silva on 17/10/2018.
//  Copyright © 2018 Hoff Henry Pereira da Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private func createView(x: Int , y: Int, width: Int, height: Int, backgroundColor: UIColor) -> UIView {
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let view = UIView(frame: frame)
        view.backgroundColor = backgroundColor
        return view
    }


}

