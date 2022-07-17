//
//  ViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundColor: UIColor = .white
    
    init(_ color:UIColor) {
        super.init(nibName: nil, bundle: nil)
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = backgroundColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
