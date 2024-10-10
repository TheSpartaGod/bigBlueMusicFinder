//
//  BaseConfigurator.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 09/10/24.
//

import UIKit

public class BaseConfigurator {
    public static let shared: BaseConfigurator = BaseConfigurator()
    
    public func createBaseScreen() -> UIViewController {
        let view: BaseMusicListViewController = BaseMusicListViewController()
        let viewModel = BaseMusicListViewModel(dataService: DataService.shared)
        view.viewModel = viewModel
    
        return view
    }
    
    
}
