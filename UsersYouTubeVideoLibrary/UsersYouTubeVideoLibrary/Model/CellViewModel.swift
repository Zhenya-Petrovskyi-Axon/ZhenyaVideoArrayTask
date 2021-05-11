//
//  CellViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import Foundation

// MARK: - Cell model for setup usage
struct CellModel {
    let id: String
    let urlString: String
    let title: String
}

class CellViewModel {
    let cellModel: CellModel
    init(_ cellModel: CellModel) {
        self.cellModel = cellModel
    }
}
