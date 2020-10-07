//
//  DetailsView.swift
//  BankLocations
//
//  Created by ramil on 07.10.2020.
//

import SwiftUI

struct DetailsView: View {
    var bankLocation: BankLocations
    
    var body: some View {
        Form {
            Section {
                HStack {
                    HStack {
                        Spacer()
                        Text("TYPE")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }.frame(width: 90)
                    HStack {
                        VStack {
                            if bankLocation.t == 0 {
                                Text("Branch")
                            } else if bankLocation.t == 1 {
                                Text("ATM")
                            } else if bankLocation.t == 2 {
                                Text("BNA")
                            }
                        }
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Spacer()
                        Text("NAME")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }.frame(width: 90)
                    HStack {
                        Text(bankLocation.n)
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Spacer()
                        Text("ADDRESS")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }.frame(width: 90)
                    HStack {
                        Text(bankLocation.a)
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Spacer()
                        Text("REGION")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }.frame(width: 90)
                    HStack {
                        Text(bankLocation.r ?? "")
                        Spacer()
                    }
                }
            }
            
            Section {
                HStack {
                    HStack {
                        Spacer()
                        Text("AVAILABILITY")
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }.frame(width: 90)
                    HStack {
                        Text(bankLocation.av ?? "")
                        Spacer()
                    }
                }
                if let info = bankLocation.i {
                    HStack {
                        HStack {
                            Spacer()
                            Text("INFO")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }.frame(width: 90)
                        HStack {
                            Text(info)
                            Spacer()
                        }
                    }
                }
            }
        }.navigationBarTitle(bankLocation.n, displayMode: .inline)
    }
}

