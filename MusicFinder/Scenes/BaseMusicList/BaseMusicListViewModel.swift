//
//  BaseMusicListViewModel.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 09/10/24.
//

import Foundation
import Alamofire

class BaseMusicListViewModel: BaseMusicListViewToVM {
    
    var view: BaseMusicListVMToView?
    var dataService: DataService?
    var searchResponse: SearchResponse?
    var playingIndex: Int?
    // MARK: cache for images
    let cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    init(dataService: DataService) {
        self.dataService = dataService
        self.dataService?.searchResponseDelegate = self
    }
    func viewDidLoad() {
        // probably not needed, since when user first navigate in we don't immediately call api
    }
    
    func searchTracks(searchTerm: String) {
        view?.showHideLoadingView(isHidden: false, errorText: nil)
        dataService?.searchTrack(searchTerm: searchTerm)
    }
    
    func getTrackCount() -> Int {
        return self.searchResponse?.resultCount ?? .zero
    }
    
    func getTrackName(index: Int) -> String {
        let trackEntry = self.searchResponse?.results?[index]
        return trackEntry?.trackName ?? trackEntry?.collectionName ?? .emptyString
    }
    
    func getArtistName(index: Int) -> String {
        return self.searchResponse?.results?[index].artistName ?? .emptyString
    }
    
    func getCollectionName(index: Int) -> String {
        return self.searchResponse?.results?[index].collectionName ?? .emptyString
    }
    
    func getStreamLink(index: Int) -> String {
        return self.searchResponse?.results?[index].previewUrl ?? .emptyString
    }
    
    func selectedTrack(index: Int) {
        let tempPlayingIndex = playingIndex
        self.playingIndex = index
        self.view?.reloadTableView(atRow: tempPlayingIndex)
        view?.playAudioFromUrl(url: getStreamLink(index: index))
       
    }
    
    func getTrackImage(index: Int, escapeAction: @escaping (Int, UIImage?) -> ()) {
        let trackImageLink = self.searchResponse?.results?[index].artworkUrl100 ?? .emptyString
        // get image from cache if it's already downloaded before
        if let imageFromCache = cache.object(forKey: trackImageLink as NSString) {
            escapeAction(index, imageFromCache)
        } else {
            dataService?.loadImageFromUrl(index: index, url: trackImageLink, escapeClosure: { [weak self] index, image, error in
                if let resultImage = image {
                    self?.cache.setObject(resultImage, forKey: trackImageLink as NSString)
                }
                escapeAction(index, image)
            })
        }
       
    }
    
    func getPlayingIndex() -> Int? {
        return self.playingIndex
    }
    
}

extension BaseMusicListViewModel: SearchResponseProtocol {
    func successGetSearchResponse(response: SearchResponse?) {
        self.searchResponse = response
        self.cache.removeAllObjects()
        self.playingIndex = nil
        view?.showHideLoadingView(isHidden: true, errorText: nil)
        view?.reloadTableView(atRow: nil)
    }
    
    func failedGetSearchRespone(error: AFError?) {
        
    }
}
