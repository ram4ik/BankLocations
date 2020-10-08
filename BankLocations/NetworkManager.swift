//
//  NetworkManager.swift
//  BankLocations
//
//  Created by ramil on 07.10.2020.
//

import Foundation

class NetworkManger {
    
    func getPosts(regionName: BankRegions, regionUrl: String, completion: @escaping ([BankLocations], Array<String>) -> ()) {
        
        guard let url = URL(string: regionUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([BankLocations].self, from: data)
            
            self.saveJsonFile(regionName.rawValue, data: data)
            
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
    
    func saveJsonFile(_ name:String, data:Data) {
        // Get the url of File in document directory
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(name + ".json")

        // Transform array into data and save it into file
        do {
            //let data = try JSONSerialization.data(withJSONObject: list, options: [])
            try data.write(to: fileUrl, options: .completeFileProtection)
        } catch {
            print(error)
        }
    }
    
//    func retrieveFromJsonFile(_ name:String) -> [JSONObject]? {
//        // Get the url of File in document directory
//        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
//        let fileUrl = documentsDirectoryUrl.appendingPathComponent(name + ".json")
//
//        // Check for file in file manager.
//        guard  (FileManager.default.fileExists(atPath: fileUrl.path))else {return nil}
//
//        // Read data from .json file and transform data into an array
//        do {
//            let data = try Data(contentsOf: fileUrl, options: [])
//            guard let list = try JSONSerialization.jsonObject(with: data, options: []) as? [JSONObject] else { return nil}
//            //print(list)
//            return list
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//
//    func removeFile(with name: String){
//        // Path for the file.
//        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return}
//        let fileUrl = documentsDirectoryUrl.appendingPathComponent(name + ".json")
//
//        if (FileManager.default.fileExists(atPath: fileUrl.absoluteString)){
//            do{
//                try FileManager.default.removeItem(at: fileUrl)
//            }catch{
//                print(error.localizedDescription)
//            }
//        }
//    }
}
