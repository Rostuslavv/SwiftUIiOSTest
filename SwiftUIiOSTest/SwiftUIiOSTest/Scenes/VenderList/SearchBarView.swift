//
//  SearchBarView.swift
//  iOSMiddleTestTask
//
//  Created by Rostyslav Dydiak on 04.12.2023.
//

import SwiftUI

struct SearchBarView: View {
    enum UIConstant {
        static let cornerRadius = 20
        static let shadowColor = 0.50
        static let shadowRadius = 10
    }
    
    @Binding var searchText: String
    @StateObject var viewModel = VendorListViewModel()
    
    var body: some View {
        HStack {
            TextField("Search...", text: $viewModel.searchText)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .opacity(!searchText.isEmpty ? 0.0 : 1.0)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .foregroundColor(.red)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            viewModel.searchText = ""
                        }
                )
        }
        .onReceive(viewModel.$debouncedSearchText) { (text) in
            searchText = text
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: CGFloat(UIConstant.cornerRadius))
                .fill(.white)
                .shadow(
                    color: .gray.opacity(UIConstant.shadowColor),
                    radius: CGFloat(UIConstant.shadowRadius), x: 0, y: 0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .previewLayout(.sizeThatFits)
}
