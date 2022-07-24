//
//  ViewController.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on for MacPaw
//
//

import UIKit
import SwiftUI
import Combine

//MARK: - Initial view
class ViewController: UIViewController {
    
    var _hostingController: UIHostingController<TheListView>! //child view
    var didLoadMainList: Bool = false //child view loaded or not
    @State var _selected_language: String = "en"
    
    //Parent scroll view for SwiftUI file
    @IBOutlet var TheScrollView: UIScrollView!
    
    //init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupList()
    }
    
//MARK: - Creating SwiftUI view inside Scroll view
    func setupList(){
        if !didLoadMainList {
            _hostingController = UIHostingController(rootView: TheListView())
            self.addChild(_hostingController)
            self.TheScrollView?.addSubview(_hostingController.view) ?? print("Unable to find the list")
            _hostingController.view.frame = CGRect(x: TheScrollView.bounds.origin.x, y: TheScrollView.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height)
            didLoadMainList = true
        }
        else {
            print("The list have already been loaded")
        }
    }
}

extension String {
func localized(lang:String) ->String {

    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)

    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
}}
