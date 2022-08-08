//
//  Models.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk for MacPaw
//

import SwiftUI

//MARK: - Structure for each element from Equipment json file
struct DataEquipment: Codable {
    var date: String
    var aircraft: Int?
    var helicopter: Int?
    var tank: Int?
    var APC: Int?
    var field_artillery: Int?
    var MRL: Int?
    var military_auto: Int?
    var fuel_tank: Int?
    var drone: Int?
    var naval_ship: Int?
    var anti_aircraft_warfare: Int?
    var special_equipment: Int?
    var mobile_SRBM_system: Int?
    var vehicles_and_fuel_tanks: Int?
    var cruise_missiles: Int?
    var greatest_losses_direction: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case aircraft = "aircraft"
        case helicopter = "helicopter"
        case tank = "tank"
        case APC = "APC"
        case field_artillery = "field artillery"
        case MRL = "MRL"
        case military_auto = "military auto"
        case fuel_tank = "fuel tank"
        case drone = "drone"
        case naval_ship = "naval ship"
        case anti_aircraft_warfare = "anti-aircraft warfare"
        case special_equipment = "special equipment"
        case mobile_SRBM_system = "mobile SRBM system"
        case vehicles_and_fuel_tanks = "vehicles and fuel tanks"
        case cruise_missiles = "cruise missiles"
        case greatest_losses_direction = "greatest losses direction"
    }
    
}
//date sample for development and as first day of war in json file is missing
extension DataEquipment {
    static var datEquip: [DataEquipment] = [
        DataEquipment(date: "2022-02-23", aircraft: 0, helicopter: 0, tank: 0, APC: 0, field_artillery: 0, MRL: 0, military_auto: 0, fuel_tank: 0, drone: 0, naval_ship: 0, anti_aircraft_warfare: 0, special_equipment: 0, mobile_SRBM_system: 0, vehicles_and_fuel_tanks: 0, cruise_missiles: 0),
        DataEquipment(date: "2022-02-24", aircraft: 7, helicopter: 6, tank: 30, APC: 130, field_artillery: 0, MRL: 0, military_auto: 0, fuel_tank: 0, drone: 0, naval_ship: 0, anti_aircraft_warfare: 0, special_equipment: 0, mobile_SRBM_system: 0, vehicles_and_fuel_tanks: 0, cruise_missiles: 0)
    ]
}


//MARK: - Structure for each element from Personnel json file
struct DataPersonnel: Codable, Identifiable {
    public var date: String?
    public var id: Int?
    public var personnel: Int
    public var personnel_a: String?
    public var POW: Int?
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case id = "day"
        case personnel = "personnel"
        case personnel_a = "personnel*"
        case POW = "POW"
    }
}
//date sample for development and as first day of war in json file is missing
extension DataPersonnel {
    static var datPers: [DataPersonnel] = [
        DataPersonnel(date: "2022-02-23", id: 0, personnel: 0, personnel_a: "about", POW: 0),
        DataPersonnel(date: "2022-02-24", id: 1, personnel: 800, personnel_a: "about", POW: 0)
    ]
}



//MARK: - Model for each element in the list
struct Models: View {
    var dataPersonnel: DataPersonnel
    var dateFormat: String
    @State private var _global_language = "uk"
    @ObservedObject var lan: Localise
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .center, spacing: 50.0) {
            Text(dateFormat).font(.title2).fontWeight(.bold).multilineTextAlignment(.leading).padding(.leading, 2).frame(width: 138)
            VStack {
                HStack {
                    Text("**\(dataPersonnel.personnel)**")
                        .padding(.trailing, -2)
                        .frame(alignment: .leading)
                    Image(systemName: "person.3").scaleEffect(0.7)
                }.frame(alignment: .leading).padding(.leading, -20)
                Text("eliminated".localized(lang: lan.general_lan))
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 30)
                    .frame(alignment: .center)
            }.frame(width: 120, height: 50, alignment: .trailing).padding(.trailing, -10)
        }
        Divider()
    }
}



//MARK: - Date Formatter

func datePicker(data: String, lan: String) -> String {
    
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    let showDate = inputFormatter.date(from: data)!
    
    if lan == "en" {
        inputFormatter.locale = Locale(identifier: "en")
        inputFormatter.dateFormat = "MMMM d"
    }
    else {
        inputFormatter.locale = Locale(identifier: "uk")
        inputFormatter.dateFormat = "d MMMM"
    }
    let resultString = inputFormatter.string(from: showDate)
    
    return resultString.capitalized
    
}


//struct Models_Previews: PreviewProvider {
//    static var previews: some View {
//        TheListView(_selected_language: _)
//    }
//}

