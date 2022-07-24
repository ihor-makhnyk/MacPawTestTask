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
    
    var body: some View{
        let dataEquipment: DataEquipment = fetch.dataEquipment[page_id]
        //23rd of February opens an empty page with "No war was here!" text
        if dataEquipment.date != "2022-02-23" {
            List {
                Section {
                    //Date
                    HStack(alignment: .center) {
                        Label(NSLocalizedString("date", comment: "") , systemImage: "calendar").frame(width: 90).multilineTextAlignment(.leading)
                        Spacer()
                        Text("**\(datePicker(data: dataEquipment.date))**")
                    }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    
                    //Personnel
                    HStack(alignment: .center) {
                        Label(NSLocalizedString("eliminated", comment: ""), systemImage: "person.3")
                        Spacer()
                        Text("**\(fetch1.dataPersonnel[page_id].personnel)**").padding(.trailing, 10).frame(alignment: .trailing)
                    }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    
                    //Losses direction
                    if dataEquipment.greatest_losses_direction != nil {
                        VStack {
                            Label(NSLocalizedString("greatest losses direction", comment: ""), systemImage: "building.2.crop.circle").frame(alignment: .trailing).frame(width: 280).padding(.leading, -18)
                            Text("**\(dataEquipment.greatest_losses_direction!)**").padding(.top, 4).frame(alignment: .leading).frame(width: 280)
                        }
                    }
                }
                
                //Air forces section
                Section(header: Text(NSLocalizedString("sec_air", comment: ""))) {
                    
                    //Aircraft
                    if dataEquipment.aircraft != nil && dataEquipment.aircraft != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("aircrafts", comment: ""), systemImage: "airplane")
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.aircraft ?? fetch.dataEquipment[page_id - 1].aircraft!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Helicopter
                    if dataEquipment.helicopter != nil && dataEquipment.helicopter != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("helicopters", comment: ""), systemImage: "fanblades").frame(alignment: .leading).scaledToFill()
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.helicopter!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Drone
                    if dataEquipment.drone != nil && dataEquipment.drone != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("drones", comment: ""), systemImage: "command").frame(alignment: .leading)
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.drone!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //SRBM systems
                    if dataEquipment.mobile_SRBM_system != nil && dataEquipment.mobile_SRBM_system != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("mobile SRBM", comment: ""), systemImage: "hurricane")
                            Spacer()
                            VStack{
                                Text("\(dataEquipment.mobile_SRBM_system ?? 0)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Cruise missiles
                    if dataEquipment.cruise_missiles != nil && dataEquipment.cruise_missiles != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("cruise missiles", comment: ""), systemImage: "applepencil")
                            Spacer()
                            VStack{
                                Text("\(dataEquipment.cruise_missiles ?? 0)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                }
                
                //Ground forces section
                Section(header: Text(NSLocalizedString("sec_ground", comment: ""))) {
                    
                    //Tanks
                    if dataEquipment.tank != nil && dataEquipment.tank != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("tanks", comment: ""), systemImage: "shield.fill")
                            Spacer()
                            VStack{
                                Text("\(dataEquipment.tank!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Artillery
                    if dataEquipment.field_artillery != nil && dataEquipment.field_artillery != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("field artillery", comment: ""), systemImage: "shield")
                            Spacer()
                            VStack(alignment: .trailing){
                                Text("\(dataEquipment.field_artillery!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Military cars
                    if dataEquipment.military_auto != nil && dataEquipment.military_auto != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("millitary auto", comment: ""), systemImage: "bus.fill")
                            Spacer()
                            VStack{
                                Text("\(dataEquipment.military_auto!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                    
                    //Armored personnel carriers
                    if dataEquipment.APC != nil && dataEquipment.APC != 0 {
                        HStack(alignment: .center) {
                            Label(NSLocalizedString("APC", comment: ""), systemImage: "shield.lefthalf.filled")
                            Spacer()
                            VStack{
                                Text("\(dataEquipment.APC!)")
                            }
                        }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    }
                }
                
                //Optional section for Support Arms (as data from here appears by some time
                if dataEquipment.fuel_tank != nil && dataEquipment.fuel_tank != 0 || dataEquipment.naval_ship != nil && dataEquipment.naval_ship != 0 {
                    
                    //Support section
                    Section(header: Text(NSLocalizedString("sec_support", comment: ""))) {
                        
                        //Fuel tanks
                        if dataEquipment.fuel_tank != nil && dataEquipment.fuel_tank != 0 {
                            HStack(alignment: .center) {
                                Label(NSLocalizedString("fuel tank", comment: ""), systemImage: "fuelpump.fill")
                                Spacer()
                                VStack{
                                    Text("\(dataEquipment.fuel_tank!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Ships
                        if dataEquipment.naval_ship != nil && dataEquipment.naval_ship != 0 {
                            HStack(alignment: .center) {
                                Label(NSLocalizedString("naval ship", comment: ""), systemImage: "ferry.fill")
                                Spacer()
                                VStack{
                                    Text("\(dataEquipment.naval_ship!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Rocket launchers
                        if dataEquipment.MRL != nil && dataEquipment.MRL != 0 {
                            HStack(alignment: .center) {
                                Label(NSLocalizedString("MRL", comment: ""), systemImage: "circle.hexagonpath.fill")
                                Spacer()
                                VStack{
                                    Text("\(dataEquipment.MRL!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Anti-aircraft warfare
                        if dataEquipment.anti_aircraft_warfare != nil && dataEquipment.anti_aircraft_warfare != 0 {
                            HStack(alignment: .center) {
                                Label(NSLocalizedString("anti-aircraft warfare", comment: ""), systemImage: "wand.and.rays")
                                Spacer()
                                VStack{
                                    Text("\(dataEquipment.anti_aircraft_warfare!)")
                                }
                            }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                        }
                        
                        //Special equipment
                        if dataEquipment.special_equipment != nil && dataEquipment.special_equipment != 0 {
                            HStack(alignment: .center) {
                                Label(NSLocalizedString("special equipment", comment: ""), systemImage: "star.circle")
                                Spacer()
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
            Text(NSLocalizedString(NSLocalizedString("was no war", comment: ""), comment: "")).bold()
        }
    }
}

