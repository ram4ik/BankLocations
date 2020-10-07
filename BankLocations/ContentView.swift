//
//  ContentView.swift
//  BankLocations
//
//  Created by ramil on 07.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var bankLocations: [BankLocations] = []
    @State private var regions = [String]()
    
    var body: some View {
        NavigationView {
            List(regions, id: \.self) { region in
                VStack {
                    NavigationLink(region, destination: RegionView(bankLocations: $bankLocations, region: region))
                }
            }
            .navigationBarTitle("Regions", displayMode: .inline)
            .onAppear() {
                NetworkManger().getPosts { (bankLocations, regions) in
                    self.regions = regions
                    self.bankLocations = bankLocations
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
