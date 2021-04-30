//
//  VideoTableViewCell.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoLinkCellLabel: UILabel!
    
    @IBOutlet weak var videoLinkCellDesriptionLabel: UILabel!
    
    private var cellDescriptionHead = "URL:"
    
    var viewModel: CellViewModel! {
        didSet {
            videoLinkCellLabel.text = viewModel.cellModel.videoLink
            videoLinkCellDesriptionLabel.text = cellDescriptionHead
        }
    }
    
    // MARK: - Setup colors & cell corners
    private lazy var setupOnce: Void = {
        videoLinkCellLabel.textColor = .blue
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor = UIColor.black.cgColor
    }()
    
    override func layoutSubviews() {
        _ = setupOnce
    }
}
