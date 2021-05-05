//
//  CellViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import Foundation

struct CellModel {
    let id: String
    let urlString: String
    let title: String
}

class CellViewModel {
    let cellModel: CellModel
    init(cellModel: CellModel) {
        self.cellModel = cellModel
    }
}
