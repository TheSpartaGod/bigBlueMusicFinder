//
//  BaseMusicViewProtocols.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 10/10/24.
//


protocol BaseMusicListViewToVM: AnyObject {
    var view: BaseMusicListVMToView? { get set }
    func viewDidLoad()
}

protocol BaseMusicListVMToView: AnyObject {
    var viewModel: BaseMusicListViewToVM? { get set }
    func showHideLoadingView(isHidden: Bool)
}
