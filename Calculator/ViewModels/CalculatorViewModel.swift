//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Apple  on 25/02/2022.
//

import Foundation
import SwiftUI

class CalculatorViewModel: ObservableObject {
    
    @Published var operation: Operations = .none
    @Published var value = "0"
    @Published var runningNumber = 0
    let keyValue = "key_value"
    
    init() {
        guard let lastValue = UserDefaults.standard.object(forKey: keyValue) as? String else { return }
        value = lastValue
    }
    
    // Operaciones que se pueden realizar.
    enum Operations {
        case none, sum, substract, multiply, divide, percent, negative, clear, decimal, equal
    }
    
    // Array de botones para mostrar en la vista
    let buttons: [[CalcButtons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine , .multiply],
        [.four, .five, .six, .less],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // Botones que se muestran en la vista
    enum CalcButtons: String {
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case decimal = ","
        case equal = "="
        case plus = "+"
        case less = "-"
        case multiply = "x"
        case divide = "/"
        case percent = "%"
        case clear = "C"
        case negative = "-/+"
        
        
        // Variable de asignación de color de fondo de botones.
        var color: Color {
            switch self {
            case .divide, .multiply, .less, .plus, .equal:
                return .orange
            case .clear, .negative, .percent:
                return Color(.lightGray)
            default:
                return Color(.darkGray)
            }
        }
    }
    
    // Función de altura de botones.
    func buttonHeight(button: CalcButtons) -> CGFloat {
        return (UIScreen.main.bounds.width - 4 * 10) / 4
    }
    
    // Función de ancho de botones.
    func buttonWidth(button: CalcButtons) -> CGFloat {
        if button == .zero {
            return ((UIScreen.main.bounds.width - 4 * 10) / 4) * 2
        }
        return (UIScreen.main.bounds.width - 5 * 10) / 4
    }
    
    // Función que gestiona el botón seleccionado y envía a la función necesaria.
    func buttonTapped(button: CalcButtons) {
        
        switch button {
            
        case .percent:
            operation = .percent
            result()
            break
        case .negative:
            operation = .negative
            result()
            break
        case .decimal:
            operation = .decimal
            break
        case .equal:
            equal()
            break
        case .plus:
            operation = .sum
            result()
            break
        case .less:
            operation = .substract
            result()
            break
        case .multiply:
            operation = .multiply
            result()
            break
        case .divide:
            operation = .divide
            result()
            break
        case .clear:
            value = "0"
            break
        default:
            let number = button.rawValue
            if value == "0" {
                value = number
            } else {
                value = "\(value)\(number)"
            }
            break
        }
    }
   
    // Gestiona re-asignación de valores y función de igualdad.
    func result() {
        
        switch operation {
            
        case .none:
            break
        case .sum:
           runningNumber = Int(value) ?? 0
            value = "0"
        case .substract:
            runningNumber = Int(value) ?? 0
            value = "0"
        case .multiply:
            runningNumber = Int(value) ?? 0
            value = "0"
        case .divide:
            runningNumber = Int(value) ?? 0
            value = "0"
        case .percent:
            runningNumber = Int(value) ?? 0
        case .negative:
            value = "\((Int(value) ?? 0) * (-1))"
        case .clear:
            value = "0"
        case .decimal:
            runningNumber = Int(value) ?? 0
        case .equal:
            equal()
        }
    }

    // Función del botón igualdad.
    func equal() {
        
        let runningValue = runningNumber
        let currentValue = Int(value) ?? 0
        
        if operation == .sum {
            value = "\(runningValue + currentValue)"
        } else if operation == .substract {
            value = "\(runningValue - currentValue)"
        } else if operation == .multiply {
            value = "\(runningValue * currentValue)"
        } else if operation == .divide {
            value = "\(runningValue / currentValue)"
        } else if operation == .percent {
            value = "\(runningValue + currentValue)"
        }
        
        // Guarda el último resultado obtenido.
        UserDefaults.standard.set(value, forKey: keyValue)
    }
    
}
