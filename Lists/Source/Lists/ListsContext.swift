//
//  ListsContext.swift
//  Lists
//
//  Created by Tony Albor on 8/4/18.
//  Copyright © 2018 Tony Albor. All rights reserved.
//

class ListsContext {
    
    private let service: ListsService
    private(set) var lists = [List]()
    
    init(service: ListsService) {
        self.service = service
    }
    
    func getLists(completion: @escaping (Result<[List]>) -> Void) {
        let request = GetListsRequest()
        service.getLists(request: request) { [weak self] result in
            self?.lists = result.value ?? []
            completion(result)
        }
    }
}
