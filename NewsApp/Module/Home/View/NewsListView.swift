//
//  NewsView.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var presenter: NewsListPresenter
    
    var body: some View {
        List(presenter.articles) { article in
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                Text(article.description ?? "No Desc")
                    .font(.subheadline)
            }
        }
        .onAppear {
            self.presenter.fetchArticles()
        }
        .navigationTitle("Top Business News")
    }
}

#if DEBUG
struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPresenter = NewsListPresenter(interactor: MockNewsListInteractor())
        return NewsListView(presenter: mockPresenter)
    }
}

class MockNewsListInteractor: NewsListInteractor {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        // Simulate mock data for preview
        let mockArticles = [
            Article(title: "Mock Article 1", description: "Description for mock article 1"),
            Article(title: "Mock Article 2", description: "Description for mock article 2"),
            Article(title: "Mock Article 3", description: "Description for mock article 3")
        ]
        completion(.success(mockArticles))
    }
}
#endif

