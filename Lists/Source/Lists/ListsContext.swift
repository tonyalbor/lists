//
//  ListsContext.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

class ListsContext {
    
    private let network: Network<ListsResponse>
    private(set) var lists = [List]()
    
    init(network: Network<ListsResponse>) {
        self.network = network
    }
    
    func getLists(completion: @escaping (Result<ListsResponse>) -> Void) {
        let request = GetListsRequest()
        network.request(request) { [weak self] result in
            self?.lists = result.value?.lists ?? []
            completion(result)
        }
    }
}
