//
//  MainScreenViewController.swift
//  HW-12
//
//  Created by Gabriel Zdravkovici on 26.09.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

    // MARK: Outlets
    
    private lazy var timerLabel: UILabel = {
       let label = UILabel()
        label.text = "Time"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 60)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        if let image = button.currentImage {
            let changedColorImage = image.withTintColor(.green, renderingMode: .alwaysOriginal)
            button.setImage(changedColorImage, for: .normal)
        }
        return button
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    // MARK: Setup
    
    private func setupHierarchy() {
        view.addSubview(timerLabel)
        view.addSubview(timerButton)
    }

    private func setupLayout() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            timerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            timerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -165),
            timerButton.widthAnchor.constraint(equalToConstant: 50),
            timerButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        
        ])
        
    }
}
