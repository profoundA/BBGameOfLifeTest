//
//  WorldModel.swift
//  BBGameOfLifeTest
//
//  Created by Andrey Lobanov on 09.08.2022.
//

import UIKit

protocol WorldModelProtocol {
    func createWorld(_ view: UIView)
    func start()
    func stop()
    func random()
}

final class WorldModel: WorldModelProtocol {
    
    private var cellsCount = 50
    private var cells = [[CellView]]()
    private var timer = Timer()
    
    func createWorld(_ view: UIView) {
        for x in 0...cellsCount   {
            var row = [CellView]()
            for y in 1...cellsCount   {
                let worldWidth = UIScreen.main.bounds.width
                let cellSize = Int((worldWidth / CGFloat(cellsCount)).rounded())
                
                let cellView = CellView(frame: CGRect(x: (x * cellSize),
                                                      y: y * cellSize - 20 ,
                                                      width: cellSize - 1,
                                                      height: cellSize - 1))
                cellView.backgroundColor = .clear
                cellView.layer.borderWidth = 0.3
                cellView.layer.borderColor = UIColor.orange.cgColor
                view.addSubview(cellView)
                row.append(cellView)
            }
            cells.append(row)
        }
    }
    
    private func changeState(x: Int, y: Int, neighbors: Int) {
        if self.cells[x][y].backgroundColor == UIColor.clear {
            if neighbors == 3 {
                self.cells[x][y].state = .alive
            }
        } else {
            switch neighbors {
            case 2...3: self.cells[x][y].state = .alive
            case ...2, 3...: self.cells[x][y].state = .dead
            default: break
            }
        }
    }
    
    private func countNeighbors(_ x: Int, _ y: Int){
        var neighbors = 0
        for xOffset in -1...1 {
            for yOffset in -1...1 {
                if !(xOffset == 0 && yOffset == 0) {
                    if self.cells[x + xOffset][y + yOffset].backgroundColor == UIColor.black {
                        neighbors += 1
                    }
                } else {
                    if self.cells[x + xOffset][y + yOffset].backgroundColor == UIColor.white {
                        neighbors -= 1
                }
            }
            }
        }
        changeState(x: x, y: y, neighbors: neighbors)
    }
    
    private func changeCellColor() {
        for x in 1..<self.cellsCount - 1 {
            for y in 1..<self.cellsCount - 1 {
                if self.cells[x][y].state == .alive {
                    self.cells[x][y].backgroundColor = .black
                } else if self.cells[x][y].state == .dead {
                    self.cells[x][y].backgroundColor = .clear
                }
            }
        }
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) {[unowned self] _ in
            for x in 1..<self.cellsCount - 1 {
                for y in 1..<self.cellsCount - 1 {
                    self.countNeighbors(x, y)
                }
            }
            self.changeCellColor()
        }
    }
    
    func stop() {
        timer.invalidate()
    }
    
    func random() {
        for x in 1..<cellsCount - 1 {
            for y in 1..<cellsCount - 1  {
                let randomInt = Int.random(in: 0...4)
                cells[x][y].state = randomInt == 0 ? .alive : .dead
                cells[x][y].backgroundColor = randomInt == 0 ? .black : .clear
            }
        }
    }
}

