//
//  ContentView.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var presenter: NewsListPresenter
    
    var body: some View {
        NavigationView {
            NewsListView(presenter: presenter)
                .navigationTitle("Top Business News")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
