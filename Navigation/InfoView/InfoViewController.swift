//
//  InfoViewController.swift
//  Navigation
//
//  Created by Mariia Khutornaia on 20.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var backgroundColor: UIColor = .white
    
    var alert: UIAlertController = {
        let alert = UIAlertController(title: .alertTitle, message: .alertMessage, preferredStyle: .alert)
        let positive = UIAlertAction(title: .alertPositiveText, style: .default) {
            UIAlertAction in
            print(String.alertPositiveText)
        }
        let negative = UIAlertAction(title: .alertNegativeText, style: .default) {
            UIAlertAction in
            print(String.alertNegativeText)
        }
        
        alert.addAction(negative)
        alert.addAction(positive)
       
        return alert
    }()
    
    init(_ color:UIColor) {
        super.init(nibName: nil, bundle: nil)
        backgroundColor = color
    }
    
    override func loadView() {
        let view = InfoView()
        self.view = view
        view.button.addTarget(self, action: #selector(openAlert), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func openAlert() {
        present(alert, animated: true, completion: nil)
    }
}

private extension String {
    static let alertTitle: String = "How are you today?"
    static let alertMessage: String = "Tracker of your mood"
    static let alertPositiveText: String = "I'am OK"
    static let alertNegativeText: String = "Not so good"
}
