//
//  MusicEntryCell.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 10/10/24.
//

import UIKit

class MusicEntryCell: UITableViewCell {
    
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistTitleLabel: UILabel!
    @IBOutlet weak var collectionTitleLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var nowPlayingIndicator: UIView!
    
    @IBOutlet weak var nowPlayingIndicatorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nowPlayingIndicator.layer.borderWidth = 4
        nowPlayingIndicator.layer.borderColor = UIColor.systemGreen.cgColor
        nowPlayingIndicator.isHidden = true
        nowPlayingIndicatorLabel.text = "Now Playing"
        nowPlayingIndicatorLabel.backgroundColor = UIColor.systemGreen
        nowPlayingIndicatorLabel.textColor = UIColor.systemBackground
    }
    
    override func prepareForReuse() {
        nowPlayingIndicator.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
