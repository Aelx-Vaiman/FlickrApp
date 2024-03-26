//
//  Photo.swift
//  FlickrApp
//
//  Created by Alex Vaiman on 10/02/2024.
//

import Foundation


struct Photos: Codable {
    let photos: PhotosData
}

/*
 page = 1
 pages = 4545
 perpage = 100
 total = "454406"
 */
struct PhotosData: Codable {
    let page: Int // api bug sometimes string sometimes int.
    let perpage: Int // api bug sometimes string sometimes int.
    let pages: Int
    let total: Int
    let photo: [Photo]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let pageStr = try? container.decode(String.self, forKey: .page) {
            page = Int(pageStr) ?? 0
        } else if let pageInt = try? container.decode(Int.self, forKey: .page) {
            page = pageInt
        } else {
            page = 0
        }
        
        if let perpageStr = try? container.decode(String.self, forKey: .perpage) {
            perpage = Int(perpageStr) ?? 0
        } else if let perpageInt = try? container.decode(Int.self, forKey: .perpage) {
            perpage = perpageInt
        } else {
            perpage = 0
        }
        
        pages = (try? container.decode(Int.self, forKey: .pages) ) ?? 0
        total = (try? container.decode(Int.self, forKey: .total) ) ?? 0
        photo = (try? container.decode([Photo].self, forKey: .photo)) ?? []
    }
}

/*
 id = "47837182682"
 owner = "98501951@N08"
 secret = "77160502ef"
 server = "65535"
 farm = 66
 title = "ULTRABIKE 2019"
 ispublic = 1
 isfriend = 0
 isfamily = 0
 */
struct Photo: Codable {
    let photoID, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    
    /*
     Source: https://stackoverflow.com/questions/64080851/invalid-farm-value-returned-by-flickr-api
    */
    
//    // Replace photos with farm id 0 with farm id 1.
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        photoID = try container.decode(String.self, forKey: .photoID)
//        owner = try container.decode(String.self, forKey: .owner)
//        secret = try container.decode(String.self, forKey: .secret)
//        server = try container.decode(String.self, forKey: .server)
//        title = try container.decode(String.self, forKey: .title)
//        ispublic = try container.decode(Int.self, forKey: .ispublic)
//        isfriend = try container.decode(Int.self, forKey: .isfriend)
//        isfamily = try container.decode(Int.self, forKey: .isfamily)
//        
//        let farm = try container.decode(Int.self, forKey: .farm)
//        self.farm = farm == 0 ? 1 : farm
//    }
    
    enum CodingKeys: String, CodingKey {
        case photoID = "id"
        case owner, secret, server, farm, title, ispublic, isfriend, isfamily
    }
}

extension Photo{
    // Replace photos with farm id 0 with farm id 1.
    func getImagePath(_ size:String = "m") -> URL?{
        let farm = self.farm == 0 ? 1 : self.farm
        let path = "https://farm\(farm).static.flickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg"
        return URL(string: path)
    }
}
