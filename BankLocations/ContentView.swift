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
        Group {
            Group {
                ContentView()
                    .previewDevice("iPhone 8")
                ContentView()
                    .preferredColorScheme(.dark)
                    .previewDevice("iPhone 8")
            }
            Group {
                ContentView()
                    .previewDevice("iPhone 8 Plus")
                ContentView()
                    .preferredColorScheme(.dark)
                    .previewDevice("iPhone 8 Plus")
            }
            Group {
                ContentView()
                    .previewDevice("iPhone 11")
                ContentView()
                    .preferredColorScheme(.dark)
                    .previewDevice("iPhone 11")
            }
            Group {
                ContentView()
                    .previewDevice("iPhone 11 Pro")
                ContentView()
                    .preferredColorScheme(.dark)
                    .previewDevice("iPhone 11 Pro")
            }
            Group {
                ContentView()
                    .previewDevice("iPhone 11 Pro Max")
                ContentView()
                    .preferredColorScheme(.dark)
                    .previewDevice("iPhone 11 Pro Max")
            }
            Group {
                ContentView()
                    .previewDevice("iPhone SE (2nd generation)")
                ContentView()
                    .preferredColorScheme(.dark)
                    .previewDevice("iPhone SE (2nd generation)")
            }
            Group {
                ContentView()
                    .previewDevice("iPod touch (7th generation)")
                ContentView()
                    .preferredColorScheme(.dark)
                    .previewDevice("iPod touch (7th generation)")
            }
        }
    }
}
