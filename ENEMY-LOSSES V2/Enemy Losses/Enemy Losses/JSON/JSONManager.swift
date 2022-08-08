//
//  JsonManager.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk for MacPaw
//

import Combine
import SwiftUI

//MARK: - Load data from Peronnel Losses JSON file using URL session
class FetchPersonnel: ObservableObject {
    
    @State var isLoading: Bool = true
    
    @Published var dataPersonnel = [DataPersonnel]()
    //yet unused, will be used for an alert if doesn't have internet to load or repository was deleted
    var show_Alert: Bool = false
    
    //repository link
    let urlPers = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"
    
    init() {
        let url = URL(string: urlPers)!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let dataPers = data {
                    let decodedData = try JSONDecoder().decode([DataPersonnel].self, from: dataPers)
                    DispatchQueue.main.async {
                        self.dataPersonnel.insert(DataPersonnel.datPers[0], at: 0)
                        self.dataPersonnel.insert(DataPersonnel.datPers[1], at: 1)
                        self.dataPersonnel.append(contentsOf: decodedData)
                        self.dataPersonnel.reverse()
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("error: ", error)
            }
        }.resume()
        self.isLoading = false
    }
    
    
}

//MARK: - Load data from Equipment Losses JSON file using URL session
class FetchEquipment: ObservableObject {
    //data structure
    @Published var dataEquipment = [DataEquipment]()
    
    //repository link
    let urlEquip = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
    
    init() {
        let url = URL(string: urlEquip)!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let dataEquip = data {
                    let decodedData = try JSONDecoder().decode([DataEquipment].self, from: dataEquip)
                    DispatchQueue.main.async {
                        self.dataEquipment.insert(DataEquipment.datEquip[0], at: 0)
                        self.dataEquipment.insert(DataEquipment.datEquip[1], at: 1)
                        self.dataEquipment.append(contentsOf: decodedData)
                    }
                } else {
                    print("No data")
                }
            } catch {
                print("error: ", error)
            }
        }.resume()
    }
}

extension String {
    func localized(lang:String) ->String {
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }}
