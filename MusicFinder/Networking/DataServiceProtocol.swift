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
    func loadImageFromUrl(index: Int, url: String, escapeClosure: @escaping (Int, UIImage?, AFError?) -> ())
}

protocol SearchResponseProtocol: AnyObject {
    func successGetSearchResponse(response: SearchResponse?)
    func failedGetSearchRespone(error: AFError?)
}
