//
//  ContentView.swift
//  Demo_1
//
//  Created by Abhijeet Gautam on 25/12/25.
// Simply Copy This In The contentView.swift File In A SwiftUI Project To Run

import SwiftUI

struct ContentView: View {
    let SIMs:[String] = ["Jio", "Vodafone Idea (VI)", "Airtel"];
    @State private var enabled:Bool = false;
    @State private var name:String = "";
    @State private var selectedSIM:String="Jio";
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select A Primary SIM", selection: $selectedSIM){
                        ForEach(SIMs, id: \.self){ sim in
                            Text(sim)
                        }
                    }
                }
                Section{
                    TextField("What Shall We Call You?", text: $name)
                    Text("\(name.count > 0 ? "Welcome, \(name)" : "Your Entered Name Will Appear Here")")
                }
                Section{
                    Text("Apple Account Suggestions")
                    Text("Expiring Soon: 3 Free months of Apple TV subscription")
                }
                Section{
                    Text("Airplane Mode")
                    Button("Wi-Fi: \(enabled ? "Enabled" : "Disabled")"){
                        enabled = !enabled;
                    }
                    Text("Bluetooth")
                    Text("Mobile Service")
                    Text("Personal Hotspot")
                    Text("Battery")
                }
                Section{
                    Text("General")
                    Text("Accessibility")
                    Text("Action Button")
                    Text("Apple Intelligence & Siri")
                    Text("Camera")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ContentView()
}
