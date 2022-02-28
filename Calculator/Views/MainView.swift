//
//  ContentView.swift
//  Calculator
//
//  Created by Apple  on 24/02/2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var calcViewModel: CalculatorViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.ignoresSafeArea()
            VStack(spacing: 15) {
                HStack {
                    Spacer()
                    Text(calcViewModel.value)
                        .font(.system(size: 75))
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
                ForEach(calcViewModel.buttons, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { item in
                            Button(item.rawValue) {
                                calcViewModel.buttonTapped(button: item)
                            }
                            .font(.largeTitle)
                            .frame(width: calcViewModel.buttonWidth(button: item), height: calcViewModel.buttonHeight(button: item), alignment: .center)
                            .background(item.color)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                        }
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CalculatorViewModel())
    }
}
