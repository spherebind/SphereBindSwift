//
//  DetailListViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 22/4/25.
//

import SwiftUI

final class DetailListViewModel: ObservableObject {
    @Published var people: [Person]
    
    init(people: [Person]) {
        self.people = people
    }
    
    func sendToBevy() {
        
    }
}
