//
//  DrinkApp.swift
//  Drink
//
//  Created by 박수연 on 9/11/24.
//

import SwiftUI

@main
struct DrinkApp: App {
    @State private var startDate: Date = UserDefaults.standard.object(forKey: "startDate") as! Date
    @State private var selectedDays: Int = UserDefaults.standard.integer(forKey: "selectedDays")
    
    var body: some Scene {
        WindowGroup {
            // TODO: 만약에 계획을 설정하지 않았다면 StartView()
            if !UserDefaults.standard.bool(forKey: "isSet") {
                StartView()
            } else { // TODO: 계획을 설정했다면(앱 내에 저장되있는 변수가 있어야 함.) HomeView()
                HomeView(startDate: $startDate, selectedDays: $selectedDays)
            }
        }
    }
}
