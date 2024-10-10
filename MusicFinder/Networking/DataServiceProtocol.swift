//
//  DataServiceProtocol.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 10/10/24.
//

import Alamofire

protocol DataServiceProtocol: AnyObject {
    var searchResponseDelegate: SearchResponseProtocol? { get set }
    
    func searchTrack(searchTerm: String)
}

protocol SearchResponseProtocol: AnyObject {
    func successGetSearchResponse(response: SearchResponse?)
    func failedGetSearchRespone(error: AFError?)
}
