//
//  VideoTableViewCell.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoLinkCellLabel: UILabel!
    @IBOutlet weak var videoLinkTitleLabel: UILabel!
    @IBOutlet weak var videoLinkCellDesriptionLabel: UILabel!
    
    private var cellDescriptionHead = "URL:"
    
    var viewModel: CellViewModel! {
        didSet {
            videoLinkTitleLabel.text = viewModel.cellModel.title
            videoLinkCellLabel.text = viewModel.cellModel.urlString
            videoLinkCellDesriptionLabel.text = cellDescriptionHead
        }
    }
    
    // MARK: - Setup colors & cell corners
    func setupView() {
        videoLinkCellLabel.textColor = .blue
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 0.3
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func layoutSubviews() {
        setupView()
    }
}
