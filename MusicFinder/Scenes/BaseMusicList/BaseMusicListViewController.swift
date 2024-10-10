//
//  BaseMusicListViewController.swift
//  MusicFinder
//
//  Created by Aqshal Wibisono on 09/10/24.
//

import UIKit

class BaseMusicListViewController: UIViewController, BaseMusicListVMToView {
    
    @IBOutlet weak var mainLoadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var firstLoadingIndicator: UIActivityIndicatorView!
    weak var viewModel: BaseMusicListViewToVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
        viewModel?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func initialViewSetup() {
        self.loadingLabel.text = "Please wait while we load your music..."
        self.firstLoadingIndicator.startAnimating()
    }
    
    func showHideLoadingView(isHidden: Bool) {
        self.mainLoadingView.isHidden = isHidden
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
