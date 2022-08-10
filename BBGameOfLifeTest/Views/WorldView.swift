//
//  WorldView.swift
//  BBGameOfLifeTest
//
//  Created by Andrey Lobanov on 09.08.2022.
//

import UIKit

final class WorldView: UIView {
    
    private var worldModel: WorldModelProtocol?
    var isPlaying = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        worldModel = WorldModel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        worldModel?.createWorld(self)
        worldModel?.random()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func start() {
        isPlaying.toggle()
        if isPlaying {
            worldModel?.start()
        }
    }
    
    func stop() {
        if !isPlaying {
            worldModel?.stop()
            
        }
    }

    func random() {
        worldModel?.random()
    }
}
