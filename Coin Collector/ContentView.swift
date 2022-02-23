//
//  ContentView.swift
//  Coin Collector
//
//  Created by Tara Frye on 12/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputAmount = 0.0
    @State private var inputUnit = "USD"
    @State private var outputUnit = "USD"
    
    @FocusState private var inputIsFocused: Bool
    
    let units = ["USD", "BTC", "ETH"]
    
    var usdConversion: Double {
        var inputToUSD = inputAmount
        if inputUnit == "BTC" {
            inputToUSD *= 48977.30
        }
        if inputUnit == "ETH" {
            inputToUSD *= 4078.96
        }
        return inputToUSD
    }

    var outputConversion: Double {
        var inputToOutput = usdConversion
        if outputUnit == "BTC" {
            inputToOutput /= 48977.30
        }
        if outputUnit == "ETH" {
            inputToOutput /= 4078.96
        }
        return inputToOutput
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)

                    Picker("Input Units", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text("\(outputConversion) \(outputUnit)")

                    Picker("Output Units", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Coin Collector")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
