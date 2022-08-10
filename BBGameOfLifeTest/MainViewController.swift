//
//  MainViewController.swift
//  BBGameOfLifeTest
//
//  Created by Andrey Lobanov on 09.08.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let startStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let randomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Random", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var worldView: WorldView = {
        let view = WorldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(worldView)
        view.addSubview(startStopButton)
        view.addSubview(randomButton)
    }
}

// MARK: Setup constraints
extension MainViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            worldView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            worldView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            worldView.widthAnchor.constraint(equalTo: view.widthAnchor),
            worldView.heightAnchor.constraint(equalTo: view.widthAnchor),
            
            startStopButton.topAnchor.constraint(equalTo: worldView.bottomAnchor, constant: 20),
            startStopButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            startStopButton.widthAnchor.constraint(equalToConstant: 100),
            startStopButton.heightAnchor.constraint(equalToConstant: 30),
            
            randomButton.topAnchor.constraint(equalTo: startStopButton.topAnchor),
            randomButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            randomButton.widthAnchor.constraint(equalTo: startStopButton.widthAnchor),
            randomButton.heightAnchor.constraint(equalTo: startStopButton.heightAnchor)
        ])
    }
}

// MARK: Setup actions
extension MainViewController {
    @objc private func startStopButtonPressed() {
        worldView.start()
        if worldView.isPlaying {
            startStopButton.setTitle("Stop", for: .normal)
        } else {
            worldView.stop()
            startStopButton.setTitle("Start", for: .normal)
        }
    }
    
    @objc private func randomButtonPressed() {
        worldView.random()
    }
    
    private func setupTargets() {
        startStopButton.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(randomButtonPressed), for: .touchUpInside)
    }
}
