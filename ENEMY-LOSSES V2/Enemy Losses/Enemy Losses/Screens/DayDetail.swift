//
//  DayDetail.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk for MacPaw
//

import Foundation
import SwiftUI

//MARK: - Page with detailed information about enemy losses
struct DayDetail: View {
    let page_id: Int!
    @ObservedObject var fetch = FetchEquipment()
    @ObservedObject var fetch1 = FetchPersonnel()
    @ObservedObject var lan: Localise
    
    var body: some View{

        let dataEquipment: DataEquipment = fetch.dataEquipment[page_id] //DataEquipment.datEquip[1]
        
        //23rd of February opens an empty page with "No war was here!" text
        if dataEquipment.date != "2022-02-23" {
            List {
                Section {
                    //Date
                    HStack(alignment: .bottom) {
                        Label("date".localized(lang: lan.general_lan), systemImage: "calendar").frame(width: 90).multilineTextAlignment(.leading).padding(.leading, -6)
                        Spacer()
                        Text("**\(datePicker(data: dataEquipment.date, lan: lan.general_lan))**")
                    }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    
                    //Personnel
                    HStack(alignment: .bottom) {
                        Label("eliminated".localized(lang: lan.general_lan), systemImage: "person")
                        Spacer()
                        Text( " +\(fetch1.dataPersonnel[fetch.dataEquipment.endIndex - page_id - 1].personnel - fetch1.dataPersonnel[fetch.dataEquipment.endIndex - page_id].personnel)").foregroundColor(.secondary).font(.caption)
                        Text("**\(fetch1.dataPersonnel[fetch.dataEquipment.endIndex - page_id - 1].personnel)**")
                        //Text("**\(DataPersonnel.datPers[1].personnel)**")
                    }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    
                    //Losses direction
                    if dataEquipment.greatest_losses_direction != nil {
                        VStack(alignment: .center) {
                            Label("greatest losses direction".localized(lang: lan.general_lan), systemImage: "building.2.crop.circle").frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                            Text("  **\(dataEquipment.greatest_losses_direction!)**  ").padding(.top, 4).frame(maxHeight: 40, alignment: .leading).background(Color.gray.opacity(0.15)).cornerRadius(10).padding(4).frame(height: 41)
                        }
                    }
                }
                
                //Air forces section
                Section(header: Text("sec_air".localized(lang: lan.general_lan))) {
                    
                    //Aircraft
                    if dataEquipment.aircraft != nil && dataEquipment.aircraft != 0 {
                        HStack(alignment: .bottom) {
                            Label("aircrafts".localized(lang: lan.general_lan), systemImage: "airplane")
                            Spacer()
                            Text( " + \(dataEquipment.aircraft! - fetch.dataEquipment[page_id - 1].aircraft! )").foregroundColor(.secondary).font(.caption)
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.aircraft ?? fetch.dataEquipment[page_id - 1].aircraft!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Helicopter
                    if dataEquipment.helicopter != nil && dataEquipment.helicopter != 0 {
                        HStack(alignment: .bottom) {
                            Label("helicopters".localized(lang: lan.general_lan), systemImage: "fanblades").frame(alignment: .leading).scaledToFill()
                            Spacer()
                            Text( " + \(dataEquipment.helicopter! - fetch.dataEquipment[page_id - 1].helicopter! )").foregroundColor(.secondary).font(.caption)
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.helicopter!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Drone
                    if dataEquipment.drone != nil && dataEquipment.drone != 0 {
                        HStack(alignment: .bottom) {
                            Label("drones".localized(lang: lan.general_lan), systemImage: "command").frame(alignment: .leading)
                            Spacer()
                            Text( " + \(dataEquipment.drone! - fetch.dataEquipment[page_id - 1].drone! )").foregroundColor(.secondary).font(.caption)
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.drone!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //SRBM systems
                    if dataEquipment.mobile_SRBM_system != nil && dataEquipment.mobile_SRBM_system != 0 {
                        HStack(alignment: .bottom) {
                            Label("mobile SRBM".localized(lang: lan.general_lan), systemImage: "hurricane")
                            Spacer()
                            Text( " + \(dataEquipment.mobile_SRBM_system! - fetch.dataEquipment[page_id - 1].mobile_SRBM_system! )").foregroundColor(.secondary).font(.caption)
                            VStack{
                                Text("\(dataEquipment.mobile_SRBM_system ?? 0)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Cruise missiles
                    if dataEquipment.cruise_missiles != nil && dataEquipment.cruise_missiles != 0 {
                        HStack(alignment: .bottom) {
                            Label("cruise missiles".localized(lang: lan.general_lan), systemImage: "applepencil")
                            Spacer()
                            Text( " + \(dataEquipment.cruise_missiles! - fetch.dataEquipment[page_id - 1].cruise_missiles! )").foregroundColor(.secondary).font(.caption)
                            VStack{
                                Text("\(dataEquipment.cruise_missiles ?? 0)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                }
                
                //Ground forces section
                Section(header: Text("sec_ground".localized(lang: lan.general_lan))) {
                    
                    //Tanks
                    if dataEquipment.tank != nil && dataEquipment.tank != 0 {
                        HStack(alignment: .bottom) {
                            Label("tanks".localized(lang: lan.general_lan), systemImage: "shield.fill")
                            Spacer()
                            Text( " + \(dataEquipment.tank! - fetch.dataEquipment[page_id - 1].tank! )").foregroundColor(.secondary).font(.caption)
                            VStack{
                                Text("\(dataEquipment.tank!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Artillery
                    if dataEquipment.field_artillery != nil && dataEquipment.field_artillery != 0 {
                        HStack(alignment: .bottom) {
                            Label("field artillery".localized(lang: lan.general_lan), systemImage: "shield")
                            Spacer()
                            Text( " + \(dataEquipment.field_artillery! - fetch.dataEquipment[page_id - 1].field_artillery! )").foregroundColor(.secondary).font(.caption)
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.field_artillery!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Military cars
                    if dataEquipment.military_auto != nil && dataEquipment.military_auto != 0 {
                        HStack(alignment: .bottom) {
                            Label("millitary auto".localized(lang: lan.general_lan), systemImage: "bus.fill")
                            Spacer()
                            Text( " + \(dataEquipment.military_auto! - fetch.dataEquipment[page_id - 1].military_auto! )").foregroundColor(.secondary).font(.caption)
                            VStack{
                                Text("\(dataEquipment.military_auto!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Armored personnel carriers
                    if dataEquipment.APC != nil && dataEquipment.APC != 0 {
                        HStack(alignment: .bottom) {
                            Label("APC".localized(lang: lan.general_lan), systemImage: "shield.lefthalf.filled")
                            Spacer()
                            Text( " + \(dataEquipment.APC! - fetch.dataEquipment[page_id - 1].APC! )").foregroundColor(.secondary).font(.caption)
                            VStack{
                                Text("\(dataEquipment.APC!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                }
                
                //Optional section for Support Arms (as data from here appears by some time
                if dataEquipment.fuel_tank != nil && dataEquipment.fuel_tank != 0 || dataEquipment.naval_ship != nil && dataEquipment.naval_ship != 0 {
                    
                    //Support section
                    Section(header: Text("sec_support".localized(lang: lan.general_lan))) {
                        
                        //Fuel tanks
                        if dataEquipment.fuel_tank != nil && dataEquipment.fuel_tank != 0 {
                            HStack(alignment: .bottom) {
                                Label("fuel tank".localized(lang: lan.general_lan), systemImage: "fuelpump.fill")
                                Spacer()
                                Text( " + \(dataEquipment.fuel_tank! - fetch.dataEquipment[page_id - 1].fuel_tank! )").foregroundColor(.secondary).font(.caption)
                                VStack{
                                    Text("\(dataEquipment.fuel_tank!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Ships
                        if dataEquipment.naval_ship != nil && dataEquipment.naval_ship != 0 {
                            HStack(alignment: .bottom) {
                                Label("naval ship".localized(lang: lan.general_lan), systemImage: "ferry.fill")
                                Spacer()
                                Text( " + \(dataEquipment.naval_ship! - fetch.dataEquipment[page_id - 1].naval_ship! )").foregroundColor(.secondary).font(.caption)
                                VStack{
                                    Text("\(dataEquipment.naval_ship!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Rocket launchers
                        if dataEquipment.MRL != nil && dataEquipment.MRL != 0 {
                            HStack(alignment: .bottom) {
                                Label("MRL".localized(lang: lan.general_lan), systemImage: "circle.hexagonpath.fill")
                                Spacer()
                                Text( " + \(dataEquipment.MRL! - fetch.dataEquipment[page_id - 1].MRL! )").foregroundColor(.secondary).font(.caption)
                                VStack{
                                    Text("\(dataEquipment.MRL!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Anti-aircraft warfare
                        if dataEquipment.anti_aircraft_warfare != nil && dataEquipment.anti_aircraft_warfare != 0 {
                            HStack(alignment: .bottom) {
                                Label("anti-aircraft warfare".localized(lang: lan.general_lan), systemImage: "wand.and.rays")
                                Spacer()
                                Text( " + \(dataEquipment.anti_aircraft_warfare! - fetch.dataEquipment[page_id - 1].anti_aircraft_warfare! )").foregroundColor(.secondary).font(.caption)
                                VStack{
                                    Text("\(dataEquipment.anti_aircraft_warfare!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Special equipment
                        if dataEquipment.special_equipment != nil && dataEquipment.special_equipment != 0 {
                            HStack(alignment: .bottom) {
                                Label("special equipment".localized(lang: lan.general_lan), systemImage: "star.circle")
                                Spacer()
                                Text( " + \(dataEquipment.special_equipment! - fetch.dataEquipment[page_id - 1].special_equipment! )").foregroundColor(.secondary).font(.caption)
                                VStack{
                                    Text("\(dataEquipment.special_equipment ?? 0)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                    }
                }
            }.navigationTitle(NSLocalizedString("day", comment: "") + "\(page_id!)")
        }
        //No war text metioned previously
        else {
            Text("was no war".localized(lang: lan.general_lan)).bold()
        }
    }
}

struct DayDetail_Previews: PreviewProvider {
    static var previews: some View {
        DayDetail(page_id: 1, lan: Localise())
    }
}
