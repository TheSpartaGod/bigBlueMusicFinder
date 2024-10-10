//
//  MusicControls.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 10/10/24.
//

import UIKit
protocol MusicControlsDelegate: AnyObject {
    func playButtonTapped()
    func pauseButtonTapped()
}

class MusicControls: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playPauseButton: UIButton!
    var delegate: MusicControlsDelegate?
    var isPlaying: Bool = false
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        setPlaying(isPlaying: !self.isPlaying)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
        setupUI()
    }
    
    func initialSetup() {
        guard let view = Bundle(for: MusicControls.self).loadNibNamed(String(describing: MusicControls.self), owner: self)?.first as? UIView else { return }
        self.contentView = view
        self.contentView.frame = bounds
        
        self.contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.backgroundColor = .clear
        self.backgroundColor = .none
        addSubview(contentView)
        self.contentView.backgroundColor = .secondarySystemBackground
        
    }
    func setupUI() {
        self.playPauseButton.setImage(nil, for: .normal)
        self.playPauseButton.setTitle("Pick your music!", for: .normal)
    }
    
    func setPlaying(isPlaying: Bool) {
        self.isPlaying = isPlaying
        if isPlaying {
            self.delegate?.playButtonTapped()
            self.playPauseButton.setTitle(.emptyString, for: .normal)
            self.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            self.delegate?.pauseButtonTapped()
            self.playPauseButton.setTitle(.emptyString, for: .normal)
            self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func startPlaying() {
        self.isPlaying = true
        self.playPauseButton.setTitle(.emptyString, for: .normal)
        self.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }

}
