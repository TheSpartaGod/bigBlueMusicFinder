//
//  DataService.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 10/10/24.
//
import Alamofire

public class DataService: DataServiceProtocol {
    public static let shared: DataService = DataService()
    var searchResponseDelegate: SearchResponseProtocol?
    
    
    private let baseUrl = "https://itunes.apple.com/search?term="
    private let defTimeoutInterval: Double = 20
    func searchTrack(searchTerm: String) {
        let urlString = baseUrl + searchTerm
        let request = AF.request(urlString, method: .get) { [weak self] in
            guard let timeout = self?.defTimeoutInterval else { return }
            $0.timeoutInterval = timeout
        }
        request.validate().responseDecodable(of: SearchResponse.self) { response in
            DispatchQueue.main.async { [weak self] in
                switch response.result {
                case .success(let response):
                    self?.searchResponseDelegate?.successGetSearchResponse(response: response)
                case .failure(let error):
                    self?.searchResponseDelegate?.failedGetSearchRespone(error: error)
                }
                
            }
        }
    }
}
