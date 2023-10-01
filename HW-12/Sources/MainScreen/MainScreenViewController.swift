//
//  MainScreenViewController.swift
//  HW-12
//
//  Created by Gabriel Zdravkovici on 26.09.2023.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    private var countdownTimer: Timer?
    private var secondsRemainingAtWork = 25
    private var secondsRemainingAtChill = 10
    private var isChillTime = Bool()
    private let circleLayer = CAShapeLayer()
    private let circleContainerView = UIView()
    
    // MARK: Outlets
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "25 sec."
        label.textColor = .red
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
        setupCircleLayer()
    }
    
    // MARK: Setup
    
    private func setupHierarchy() {
        let views = [timerLabel, timerStartButton, timerPauseButton, statusLabel,circleContainerView]
        views.forEach { view.addSubview($0) }
    }
    
    private func setupLayout() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerStartButton.translatesAutoresizingMaskIntoConstraints = false
        timerPauseButton.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        circleContainerView.translatesAutoresizingMaskIntoConstraints = false
        
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
            statusLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -100),
            
            circleContainerView.topAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -10),
            circleContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 100)
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
        timerLabel.textColor = .orange
        circleLayer.strokeColor = UIColor.orange.cgColor
        
        if isChillTime {
            statusLabel.text = "Work is done!✅ Need to chill😎"
            statusLabel.font = .boldSystemFont(ofSize: 25)
            statusLabel.textColor = .purple
            timerLabel.textColor = .purple
           
        }
        
        // Получаем текущее время анимации
        let pausedTime = circleLayer.timeOffset
        circleLayer.speed = 1.0
        circleLayer.timeOffset = 0.0
        circleLayer.beginTime = 0.0
        
        let timeSincePause = circleLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        circleLayer.beginTime = timeSincePause
        animateCircle(with: secondsRemainingAtWork)
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
        timerLabel.textColor = .brown
        
        let pausedTime = circleLayer.convertTime(CACurrentMediaTime(), from: nil)
        circleLayer.speed = 0.0
        circleLayer.timeOffset = pausedTime
    }
    
    private func relaunchTimer() {
        isChillTime = false
        statusLabel.text = "Working... 🔨"
        statusLabel.font = .boldSystemFont(ofSize: 55)
        statusLabel.textColor = .orange
        timerLabel.textColor = .orange
        circleLayer.strokeColor = UIColor.orange.cgColor
        secondsRemainingAtWork = 25
        secondsRemainingAtChill = 10
        updateTimer()
        animateCircle(with: secondsRemainingAtWork)
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
            statusLabel.textColor = .purple
            timerLabel.textColor = .purple
            circleLayer.strokeColor = UIColor.purple.cgColor
            animateCircle(with: secondsRemainingAtChill)
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
    
    // Настройка Circle
    
    func setupCircleLayer() {
        circleLayer.frame = timerLabel.bounds
        circleLayer.lineWidth = 8.0
        circleLayer.fillColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0).cgColor
        circleLayer.path = UIBezierPath(arcCenter: CGPoint(x: timerLabel.bounds.midX, y: timerLabel.bounds.midY), radius: (250) / 2, startAngle: 3 * CGFloat.pi / 2, endAngle: -CGFloat.pi / 2, clockwise: false).cgPath
        circleLayer.strokeEnd = 0.0
        circleLayer.position = CGPoint(x: 90, y: 70)
//        circleLayer.strokeColor = UIColor.green.cgColor
        circleContainerView.layer.addSublayer(circleLayer)
        
    }
    
    private func animateCircle(with durationType: Int) {
        // Определяем начальное и конечное значение для анимации
        let startValue: CGFloat = CGFloat(Float(durationType) / Float(25))
        let endValue: CGFloat = 0.0
        // Создаем анимацию
        let animation = CAKeyframeAnimation(keyPath: "strokeEnd")
        animation.values = [startValue, endValue]
        animation.keyTimes = [0, 1]
        animation.duration = Double(durationType)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        // Добавляем анимацию к CAShapeLayer
        circleLayer.add(animation, forKey: "circleAnimation")
    }
}



