//
//  VendorListViewModel.swift
//  SwiftUIiOSTest
//
//  Created by Rostyslav Dydiak on 01.12.2023.
//

import SwiftUI
import Combine

class VendorListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var debouncedSearchText = ""
    
    private var subscriptions = Set<AnyCancellable>()
    var cards: Cards = try! LocalFilesProvider.init(resource: "vendors", resourceExtension: "json").getData()
    
    var filterName: [Vendor] {
        guard !searchText.isEmpty else { return cards.vendors }
        guard searchText.count > 2 else { return cards.vendors }
        
        return cards.vendors.filter { $0.companyName.localizedStandardContains(searchText) }
    }
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                self?.debouncedSearchText = text
            } )
            .store(in: &subscriptions)
    }
}
