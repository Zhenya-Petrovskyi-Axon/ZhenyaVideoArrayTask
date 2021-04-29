//
//  VideoTableViewCell.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoLinkCellLabel: UILabel!
    
    @IBOutlet weak var videoLinkCellImage: UIImageView!
    
    var viewModel: CellViewModel! {
        didSet {
            videoLinkCellLabel.text = viewModel.cellModel.videoLink
        }
    }
    
    override func layoutSubviews() {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
