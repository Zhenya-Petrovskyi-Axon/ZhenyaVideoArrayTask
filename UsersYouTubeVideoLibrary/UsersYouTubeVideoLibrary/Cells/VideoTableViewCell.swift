//
//  VideoTableViewCell.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit

struct CellModel {
    let videoLink: String
}

class VideoCollectionViewModel {
    let cellModel: CellModel
    init(cellModel: CellModel) {
        self.cellModel = cellModel
    }
}

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoLinkCellLabel: UILabel!
    
    @IBOutlet weak var videoLinkCellImage: UIImageView!
    
    var viewModel: VideoCollectionViewModel! {
        didSet {
            videoLinkCellLabel.text = viewModel.cellModel.videoLink
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
