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
        label.text = "25 sec."
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
        button.addTarget(self, action: #selector(timerStartButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var timerPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause"), for: .normal)
        if let image = button.currentImage {
            let changedColorImage = image.withTintColor(.red, renderingMode: .alwaysOriginal)
            button.setImage(changedColorImage, for: .normal)
        }
        button.addTarget(self, action: #selector(timerPauseButtonPressed), for: .touchUpInside)
        button.isHidden = true
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
        view.addSubview(timerPauseButton)
    }

    private func setupLayout() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerStartButton.translatesAutoresizingMaskIntoConstraints = false
        timerPauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            timerStartButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            timerStartButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -175),
            timerStartButton.widthAnchor.constraint(equalToConstant: 50),
            timerStartButton.heightAnchor.constraint(equalToConstant: 50),
            
            timerPauseButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            timerPauseButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -165),
            timerPauseButton.widthAnchor.constraint(equalToConstant: 70),
            timerPauseButton.heightAnchor.constraint(equalToConstant: 70)
        
        ])
    }
    
    // MARK: - Actions
    
    @objc private func timerStartButtonPressed() {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerStartButton.isEnabled = false
        timerStartButton.isHidden = true
        timerPauseButton.isEnabled = true
        timerPauseButton.isHidden = false
    }
    
    @objc private func timerPauseButtonPressed() {
           countdownTimer?.invalidate()
        timerStartButton.isEnabled = true
        timerStartButton.isHidden = false
        timerPauseButton.isEnabled = false
        timerPauseButton.isHidden = true
       }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            let minutes = secondsRemaining / 60
            let seconds = secondsRemaining % 60
            timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            // Таймер завершен
            timerLabel.text = "0 sec."
            countdownTimer?.invalidate()
        }
    }
}


