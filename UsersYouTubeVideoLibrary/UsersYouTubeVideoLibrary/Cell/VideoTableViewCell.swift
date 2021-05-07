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
    @IBOutlet weak var viewForLabels: UIView!
    
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
        viewForLabels.layer.masksToBounds = true
        viewForLabels.layer.cornerRadius = 15
        viewForLabels.layer.borderWidth = 0.3
        viewForLabels.layer.borderColor = UIColor.black.cgColor
        viewForLabels.backgroundColor = .systemGray4
    }
    
    override func layoutSubviews() {
        setupView()
    }
}
