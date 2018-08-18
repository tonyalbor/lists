//
//  ListsService.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

struct List {
    let id: Int
    let name: String
    let imageURL: String
    let ownerId: Int
}

extension List: Decodable {
    enum Keys: String, CodingKey {
        case id
        case name
        case imageURL = "imageUrl"
        case ownerId
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = List(id: try container.decode(Int.self, forKey: .id),
                    name: try container.decode(String.self, forKey: .name),
                    imageURL: try container.decode(String.self, forKey: .imageURL),
                    ownerId: try container.decode(Int.self, forKey: .ownerId))
    }
    init?(json: Json) {
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String,
              let imageURL = json["imageUrl"] as? String,
              let ownerId = json["ownerId"] as? Int else {
            return nil
        }
        self = List(id: id, name: name, imageURL: imageURL, ownerId: ownerId)
    }
}

struct GetListsRequest: ListsRequest {
    let method = HttpMethod.get
    let urlString = "lists"
}

protocol ListsService {
    func getLists(request: GetListsRequest, completion: @escaping (Result<[List]>) -> Void)
}

struct ListsServiceImp: ListsService {
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func getLists(request: GetListsRequest, completion: @escaping (Result<[List]>) -> Void) {
        network.requestJson(request) { result in
            completion(result.mapOptional { json -> [List]? in
                guard let lists = json["lists"] as? [Json] else {
                    return nil
                }
                return lists.compactMap(List.init)
            })
        }
    }
}
