//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI

@main
struct NewsAppApp: App {
    var body: some Scene {
           WindowGroup {
               ContentView()
                   .environmentObject(NewsListPresenter(interactor: NewsListInteractorImpl()))
           }
       }
   }
