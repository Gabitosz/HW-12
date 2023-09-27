//
//  MainScreenViewController.swift
//  HW-12
//
//  Created by Gabriel Zdravkovici on 26.09.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

    private var countdownTimer: Timer?
    private var secondsRemaining = 25
    
    // MARK: Outlets
    
    private lazy var timerLabel: UILabel = {
       let label = UILabel()
        label.text = "25"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 60)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timerStartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        if let image = button.currentImage {
            let changedColorImage = image.withTintColor(.green, renderingMode: .alwaysOriginal)
            button.setImage(changedColorImage, for: .normal)
        }
        button.addTarget(self, action: #selector(timerButtonPressed), for: .touchUpInside)
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
        view.addSubview(timerStartButton)
    }

    private func setupLayout() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerStartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            timerStartButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            timerStartButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -165),
            timerStartButton.widthAnchor.constraint(equalToConstant: 50),
            timerStartButton.heightAnchor.constraint(equalToConstant: 50)
            
        
        ])
    }
    
    // MARK: - Actions
    
    @objc private func timerButtonPressed() {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            timerLabel.text = "\(secondsRemaining)"
        } else {
            // Таймер завершен
            timerLabel.text = "0"
            countdownTimer?.invalidate()
        }
    }
}


