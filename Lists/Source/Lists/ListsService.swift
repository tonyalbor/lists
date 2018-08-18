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

extension List {
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
