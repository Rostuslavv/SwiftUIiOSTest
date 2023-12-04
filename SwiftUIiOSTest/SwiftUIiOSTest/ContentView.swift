//
//  ContentView.swift
//  iOSMiddleTestTask
//
//  Created by Rostyslav Dydiak on 01.12.2023.
//

import SwiftUI

struct ContentView: View {
    private var cards: Cards = Bundle.main.decode(file: "vendors.json")
    @State private var serchTerm = ""
    
    var filterName: [Vendor] {
        guard !serchTerm.isEmpty else { return cards.vendors}
        guard serchTerm.count > 2 else { return cards.vendors}
        
        return cards.vendors.filter { $0.companyName.localizedStandardContains(serchTerm) }
    }
    
    var body: some View {
        SearchBarView(searchText: $serchTerm)
        
        if serchTerm.count >= 3 {
            if serchTerm != "" && cards.vendors.filter( { $0.companyName.lowercased().contains(self.serchTerm.lowercased())}).count == 0 {
                
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
            ForEach(filterName, id: \.companyName) { card in
                
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
                                    Image("bookmark")
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
                            Image("Vector")
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
    }
}

#Preview {
    ContentView()
}
