//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Apple  on 24/02/2022.
//

import SwiftUI

@main
struct CalculatorApp: App {
    
    var calculatorViewModel: CalculatorViewModel = CalculatorViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(calculatorViewModel)
        }
    }
}
