//
//  CellView.swift
//  BBGameOfLifeTest
//
//  Created by Andrey Lobanov on 09.08.2022.
//

import UIKit

enum State {
    case dead
    case alive
}

final class CellView: UIView {
    var state: State = .alive
}
