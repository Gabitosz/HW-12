//
//  MainScreenViewController.swift
//  HW-12
//
//  Created by Gabriel Zdravkovici on 26.09.2023.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    private var countdownTimer: Timer?
    private var secondsRemainingAtWork = 2
    private var secondsRemainingAtChill = 10
    private var isWorkTime = Bool()
    private var isChillTime = Bool()
    private var isStarted = Bool()
    
    // MARK: Outlets
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "25 sec."
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 60)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Pomodoro 🍅"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 55)
        label.textAlignment = .center
        label.numberOfLines = 2
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
        let views = [timerLabel, timerStartButton, timerPauseButton, statusLabel]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerStartButton.translatesAutoresizingMaskIntoConstraints = false
        timerPauseButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            timerStartButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 30),
            timerStartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerStartButton.widthAnchor.constraint(equalToConstant: 50),
            timerStartButton.heightAnchor.constraint(equalToConstant: 50),
            
            timerPauseButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20),
            timerPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timerPauseButton.widthAnchor.constraint(equalToConstant: 70),
            timerPauseButton.heightAnchor.constraint(equalToConstant: 70),
            
            statusLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -100)
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func timerStartButtonPressed() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerStartButton.isEnabled = false
        timerStartButton.isHidden = true
        timerPauseButton.isEnabled = true
        timerPauseButton.isHidden = false
        statusLabel.text = "Working... 🔨"
        statusLabel.textColor = .orange
    }
    
    @objc private func timerPauseButtonPressed() {
        countdownTimer?.invalidate()
        timerStartButton.isEnabled = true
        timerStartButton.isHidden = false
        timerPauseButton.isEnabled = false
        timerPauseButton.isHidden = true
        statusLabel.text = "Coffee break... ☕️"
        statusLabel.font = .boldSystemFont(ofSize: 45)
        statusLabel.textColor = .brown
    }
    
    private func relaunchTimer() {
        statusLabel.text = "Working... 🔨"
        secondsRemainingAtWork = 25
        secondsRemainingAtChill = 10
        updateTimer()
    }
    
    @objc private func updateTimer() {
        if secondsRemainingAtWork > 0 {
            secondsRemainingAtWork -= 1
            let minutes = secondsRemainingAtWork / 60
            let seconds = secondsRemainingAtWork % 60
            timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            // Таймер завершен
            isChillTime = true
            statusLabel.text = "Work is done!✅ Need to chill😎"
            statusLabel.font = .boldSystemFont(ofSize: 25)
            if secondsRemainingAtChill > 0 {
                secondsRemainingAtChill -= 1
                let minutes = secondsRemainingAtChill / 60
                let seconds = secondsRemainingAtChill % 60
                timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            } else {
                relaunchTimer()
            }
        }
    }
    
    //            timerLabel.text = "0 sec."
    
    //      countdownTimer?.invalidate()
}



