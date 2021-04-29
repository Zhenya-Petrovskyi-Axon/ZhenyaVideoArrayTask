//
//  VideoTableViewCell.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoLinkCellLabel: UILabel!
    
    private var cellDescriptionHead = "URL:"
    
    var viewModel: CellViewModel! {
        didSet {
            videoLinkCellLabel.text = cellDescriptionHead + " " + viewModel.cellModel.videoLink
        }
    }
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
