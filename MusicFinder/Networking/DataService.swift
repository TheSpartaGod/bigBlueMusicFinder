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
    func loadImageFromUrl(index: Int, url: String, escapeClosure: @escaping (Int, UIImage?, AFError?) -> ()) {
        let request = AF.request(url, method: .get) { [weak self] in
            guard let timeout = self?.defTimeoutInterval else { return }
            $0.timeoutInterval = timeout
        }
        var responseImage: UIImage?
        var responseError: AFError?
        request.response { response in
            DispatchQueue.main.async { [weak self] in
                switch response.result {
                case .success(let data):
                    guard let data = data, let image: UIImage = UIImage(data: data) else { return }
                    responseImage = image
                    escapeClosure(index, responseImage, responseError)
                    print("acquired image")
                case .failure(let error):
                    responseError = error
                    print("error in image! \(error.localizedDescription)")
                    escapeClosure(index, responseImage, responseError)
                }
            }
        }
    }
}
