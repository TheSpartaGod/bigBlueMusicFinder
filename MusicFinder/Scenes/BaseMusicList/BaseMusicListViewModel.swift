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
    
    init(dataService: DataService) {
        self.dataService = dataService
        self.dataService?.searchResponseDelegate = self
    }
    func viewDidLoad() {
        // probably not needed, since when user first navigate in we don't immediately call api
        searchTracks(searchTerm: "charliexcx")
    }
    
    func searchTracks(searchTerm: String) {
        if self.searchResponse == nil {
            view?.showHideLoadingView(isHidden: false, errorText: nil)
        }
        dataService?.searchTrack(searchTerm: searchTerm)
    }
    
    func getTrackCount() -> Int {
        return self.searchResponse?.resultCount ?? .zero
    }
    
    func getTrackName(index: Int) -> String {
        return self.searchResponse?.results?[index].trackName ?? .emptyString
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
        view?.playAudioFromUrl(url: getStreamLink(index: index))
    }
    
    
}

extension BaseMusicListViewModel: SearchResponseProtocol {
    func successGetSearchResponse(response: SearchResponse?) {
        self.searchResponse = response
        view?.showHideLoadingView(isHidden: true, errorText: nil)
        view?.reloadTableView()
    }
    
    func failedGetSearchRespone(error: AFError?) {
        
    }
}
