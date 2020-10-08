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
    @State private var selectedRegion = BankRegions.estonia
    @State private var regionUrl = ""
    @State private var showSheetView = false
    
    @State private var newDate = Date()
    let timer = Timer.publish(every: 3600, on: .current, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            List(regions, id: \.self) { region in
                VStack {
                    NavigationLink(region, destination: RegionView(bankLocations: $bankLocations, region: region))
                }
            }
            .navigationBarTitle("Regions", displayMode: .inline)
            .onAppear() {
                getData()
            }.navigationBarItems(leading:
                                    Button(action: {
                                        getData()
                                    }, label: {
                                        Image(systemName: "arrow.counterclockwise")
                                    })
                                 ,
                                 trailing:
                                    Button(action: {
                                        showSheetView.toggle()
                                    }, label: {
                                        Image(systemName: "gear")
                                    })
            )
            
        }.onAppear() {
            getRegionUrl()
        }.sheet(isPresented: $showSheetView, onDismiss: { getData() }, content: {
            NavigationView {
                Form {
                    Picker("Select country", selection: $selectedRegion) {
                        ForEach(BankRegions.allCases, id: \.self) { country in
                            Text(country.rawValue)
                        }
                    }
                }
            }
        }).onReceive(timer) { _ in
            self.newDate = Date()
            getData()
        }
    }
    
    func getRegionUrl() {
        switch selectedRegion {
        case .estonia:
            regionUrl = "https://www.swedbank.ee/finder.json"
        case .latvia:
            regionUrl = "https://ib.swedbank.lv/finder.json"
        case .lithuenia:
            regionUrl = "https://ib.swedbank.lt/finder.json"
        }
    }
    
    func getData() {
        getRegionUrl()
        NetworkManger().getPosts(regionUrl: regionUrl) { (bankLocations, regions) in
            self.regions = regions
            self.bankLocations = bankLocations
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
