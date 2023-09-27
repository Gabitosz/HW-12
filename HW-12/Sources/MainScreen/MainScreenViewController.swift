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
    }

    private func setupLayout() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
        
        ])
        
    }
}

