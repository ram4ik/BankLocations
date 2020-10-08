//
//  NetworkManager.swift
//  BankLocations
//
//  Created by ramil on 07.10.2020.
//

import Foundation

class NetworkManger {
    
    func getPosts(regionUrl: String, completion: @escaping ([BankLocations], Array<String>) -> ()) {
        
        guard let url = URL(string: regionUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([BankLocations].self, from: data)
            
            let regionList: Array<String> = self.getAllRegions(bankLocations: posts)
            
            DispatchQueue.main.async {
                completion(posts, regionList)
            }
        }.resume()
    }
    
    func getAllRegions(bankLocations: [BankLocations]) -> Array<String> {
        
        var allRegionsList = [String]()
        
        for bankLocation in bankLocations {
            if let region = bankLocation.r {
                allRegionsList.append(region)
            }
        }
        
        return Array(Set(allRegionsList)).sorted()
    }
}
