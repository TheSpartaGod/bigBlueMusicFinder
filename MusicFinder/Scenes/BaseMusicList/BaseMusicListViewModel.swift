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
    
    init(dataService: DataService) {
        self.dataService = dataService
        self.dataService?.searchResponseDelegate = self
    }
    func viewDidLoad() {
        dataService?.searchTrack(searchTerm: "charliexcx")
    }
    
}

extension BaseMusicListViewModel: SearchResponseProtocol {
    func successGetSearchResponse(response: SearchResponse?) {
        print("you've got some music: \(response?.resultCount)")
    }
    
    func failedGetSearchRespone(error: AFError?) {
        
    }
}
