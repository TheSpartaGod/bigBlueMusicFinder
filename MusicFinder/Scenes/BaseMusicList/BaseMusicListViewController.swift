//
//  BaseMusicListViewController.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 09/10/24.
//

import UIKit
import AVFoundation

class BaseMusicListViewController: UIViewController, BaseMusicListVMToView {

    @IBOutlet weak var mainLoadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var firstLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var musicListTableView: UITableView!
    
    @IBOutlet weak var musicControls: MusicControls!
    let identifier = "MusicEntryCell"
    let loadingText = "Please wait while we load your music..."
    var player: AVPlayer?
    weak var viewModel: BaseMusicListViewToVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        viewModel?.viewDidLoad()
    }
    
    private func initialViewSetup() {
        self.musicListTableView.register(UINib(nibName: String(describing: MusicEntryCell.self), bundle: nil), forCellReuseIdentifier: identifier)
        self.musicListTableView.dataSource = self
        self.musicListTableView.delegate = self
        self.musicControls.delegate = self
        self.loadingLabel.text = loadingText
        self.mainLoadingView.isHidden = true
    }
    
    func showHideLoadingView(isHidden: Bool, errorText: String?) {
        // used when loading / display error
        self.mainLoadingView.isHidden = isHidden
        self.musicListTableView.isHidden = !isHidden
        (isHidden || errorText == nil) == true ? firstLoadingIndicator.stopAnimating() : firstLoadingIndicator.startAnimating()
        if let errorText = errorText {
            self.loadingLabel.text = errorText
        } else {
            self.loadingLabel.text = self.loadingText
        }
    }
    
    func reloadTableView() {
        self.musicListTableView.reloadData()
    }
    
    func playAudioFromUrl(url: String) {
        guard let url = URL.init(string: url) else {
            // TODO: error handling
            print("returned an invalid URL for streaming")
            return
        }
        
        let playerItem: AVPlayerItem = AVPlayerItem(url: url)
        if self.player?.timeControlStatus == .playing {
        // stop player if running
            self.player?.replaceCurrentItem(with: playerItem)
        } else {
            self.player = AVPlayer(playerItem: playerItem)
            player?.play()
        }
    }
}

extension BaseMusicListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getTrackCount() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MusicEntryCell else {
            return UITableViewCell() }
        cell.trackTitleLabel.text = viewModel?.getTrackName(index: indexPath.row)
        cell.artistTitleLabel.text = viewModel?.getArtistName(index: indexPath.row)
        cell.collectionTitleLabel.text = viewModel?.getCollectionName(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectedTrack(index: indexPath.row)
    }
}

extension BaseMusicListViewController: MusicControlsDelegate {
    func playButtonTapped() {
        self.player?.play()
    }
    
    func pauseButtonTapped() {
        self.player?.pause()
    }
    
    
}
