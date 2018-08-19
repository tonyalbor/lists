//
//  List.swift
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
}

struct ListsResponse {
    let lists: [List]
}

extension ListsResponse: Decodable {

    enum Keys: String, CodingKey {
        case lists
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self = ListsResponse(lists: try container.decode([List].self, forKey: .lists))
    }
}

struct GetListsRequest: ListsRequest {
    let method = HttpMethod.get
    let urlString = "lists"
}
