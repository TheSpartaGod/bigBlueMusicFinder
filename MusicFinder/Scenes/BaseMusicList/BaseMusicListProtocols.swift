//
//  BaseMusicViewProtocols.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 10/10/24.
//

import UIKit

protocol BaseMusicListViewToVM: AnyObject {
    var view: BaseMusicListVMToView? { get set }
    func viewDidLoad()
    func searchTracks(searchTerm: String)
    func getTrackCount() -> Int
    func getTrackName(index: Int) -> String
    func getArtistName(index: Int) -> String
    func getCollectionName(index: Int) -> String
    func getStreamLink(index: Int) -> String 
    func selectedTrack(index: Int)
    func getTrackImage(index: Int, escapeAction: @escaping (Int, UIImage?) -> ())
    func getPlayingIndex() -> Int?
}

protocol BaseMusicListVMToView: AnyObject {
    var viewModel: BaseMusicListViewToVM? { get set }
    func showHideLoadingView(isHidden: Bool, errorText: String?)
    func reloadTableView(atRow: Int?)
    func playAudioFromUrl(url: String)
}
