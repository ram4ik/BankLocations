//
//  RegionView.swift
//  BankLocations
//
//  Created by ramil on 07.10.2020.
//

import SwiftUI

struct RegionView: View {
    
    @Binding var bankLocations: [BankLocations]
    var region: String
    
    var body: some View {
        List(self.filterRegions(bankLocation: bankLocations, by: region)) { location in
            NavigationLink(destination: DetailsView(bankLocation: location)) {
                HStack {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(location.t == 0 ? .blue : (location.t == 1 ? .orange : .green))
                        
                        VStack {
                            if location.t == 0 {
                                Text("BR")
                            } else if location.t == 1 {
                                Text("A")
                            } else if location.t == 2 {
                                Text("R")
                            }
                        }.foregroundColor(.white)
                    }
                    VStack(alignment: .leading) {
                        Text(location.n)
                            .font(.title2)
                        Text(location.a)
                            .foregroundColor(.secondary)
                            .font(.title3)
                    }
                }
            }
            
        }.navigationBarTitle(region, displayMode: .inline)
    }
    
    func filterRegions(bankLocation: [BankLocations], by region: String) -> [BankLocations] {
        return bankLocation.filter { $0.r == region }
    }
}
