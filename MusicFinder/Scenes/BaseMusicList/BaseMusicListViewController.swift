//
//  BaseMusicListViewController.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 09/10/24.
//

import UIKit

class BaseMusicListViewController: UIViewController, BaseMusicListVMToView {

    @IBOutlet weak var mainLoadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var firstLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var musicListTableView: UITableView!
    let identifier = "MusicEntryCell"
    let loadingText = "Please wait while we load your music..."
    weak var viewModel: BaseMusicListViewToVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        viewModel?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func initialViewSetup() {
        self.musicListTableView.register(UINib(nibName: String(describing: MusicEntryCell.self), bundle: nil), forCellReuseIdentifier: identifier)
        self.musicListTableView.dataSource = self
        self.musicListTableView.delegate = self
        
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
}
