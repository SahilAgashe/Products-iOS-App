//
//  DetailsViewController.swift
//  SAA-App
//
//  Created by SAHIL AGASHE on 05/07/24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private lazy var firstLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "First Label"
        return lbl
    }()
    
    private lazy var secondLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Second Label"
        return lbl
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
    
        vStack.addArrangedSubview(firstLabel)
        vStack.addArrangedSubview(secondLabel)
        vStack.axis = .vertical
        vStack.alignment = .center
        
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.widthAnchor.constraint(equalToConstant: view.frame.width),
            vStack.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    public func setData(textInput text1: String, and text2: String) {
        firstLabel.text = text1
        secondLabel.text = text2
    }
}
