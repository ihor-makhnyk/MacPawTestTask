//
//  ViewSettings.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk for MacPaw
//

import SwiftUI

//MARK: - Settings initial view
class ViewSettings: UIViewController {
    
    var _hostingController: UIHostingController<SettingsUI>! //child settings view
    @IBOutlet var MainView: UIView! //parent
    
    //init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
    }
    
//MARK: - Load child view function
    func setupSettings(){
        _hostingController = UIHostingController(rootView: SettingsUI())
        self.addChild(_hostingController)
        self.MainView?.addSubview(_hostingController.view) ?? print("Unable to find the list")
        _hostingController.view.frame = CGRect(x: MainView.bounds.origin.x, y: MainView.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    
}
