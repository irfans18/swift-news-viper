//
//  ContentView.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var presenter: NewsPresenter
    
    var body: some View {
        NewsListView(presenter: presenter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(NewsPresenter(interactor: NewsListInteractor()))
    }
}
