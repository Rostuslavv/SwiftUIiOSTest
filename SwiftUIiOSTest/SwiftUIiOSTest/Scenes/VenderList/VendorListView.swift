//
//  VendorListView.swift
//  SwiftUIiOSTest
//
//  Created by Rostyslav Dydiak on 01.12.2023.
//

import SwiftUI

struct VendorListView: View {
    @StateObject var viewModel = VendorListViewModel()
    
    var body: some View {
        SearchBarView(searchText: $viewModel.searchText)
            .zIndex(1)
        
        if viewModel.searchText.count >= 3 {
            if viewModel.searchText != "" && viewModel.cards.vendors.filter( { $0.companyName.lowercased().contains(viewModel.searchText.lowercased())}).count == 0 {
                
                VStack {
                    Spacer()
                    Text("Sorry! No results found...")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("ErrorGreen"))
                        .font(.title)
                        .bold()
                    Text("Please try a different search request or browse businesses from the list")
                        .foregroundColor(Color("TextColor"))
                        .multilineTextAlignment(.center)
                }
            }
        }
        
        List {
            ForEach(viewModel.filterName, id: \.companyName) { card in
                
                VStack(alignment: .leading, content: {
                    AsyncImage(
                        url: URL(string: card.coverPhoto.mediaURL),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                                .blur(radius: 0.5)
                                .overlay(alignment: .bottomLeading) {
                                    Text("\(card.areaServed)")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding(.vertical, 16)
                                        .padding(.horizontal, 10)
                                        .cornerRadius(16)
                                }
                                .overlay(alignment: .topTrailing) {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 31))
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding(.top, 10)
                                        .padding(.trailing, 10)
                                }
                                .overlay(alignment: .topTrailing) {
                                    Image("Bookmark")
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .padding(.top, 16)
                                        .padding(.trailing, 16)
                                }
                            
                        }, placeholder: {
                            Color.white
                        })
                    
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    
                    Text("\(card.companyName)")
                        .bold()
                    HStack {
                        ForEach(card.categories, id: \.name) { categorie in
                            Image("Categorie")
                                .frame(width: 22, height: 22)
                            Text("\(categorie.name)")
                                .lineLimit(1)
                        }
                    }
                    .padding(8)
                    
                    HStack {
                        ForEach(card.tags, id: \.name) { tag in
                            Image(systemName: "circle.fill")
                                .foregroundColor(.gray)
                                .font(.system(size: 5))
                                .frame(width: 3)
                            
                            Text("\(tag.name)")
                                .font(.subheadline)
                        }
                    }
                })
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(GroupedListStyle())
        .padding(.top, -10)
        .background(.clear)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    VendorListView()
}
