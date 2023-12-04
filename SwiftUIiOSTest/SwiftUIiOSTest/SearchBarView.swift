//
//  SearchBarView.swift
//  iOSMiddleTestTask
//
//  Created by Rostyslav Dydiak on 04.12.2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchText)
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
                            searchText = ""
                        }
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.white)
                .shadow(
                    color: .gray.opacity(0.50),
                    radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
        .previewLayout(.sizeThatFits)
}
