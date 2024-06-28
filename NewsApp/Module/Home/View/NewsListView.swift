//
//  NewsView.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var presenter: NewsListPresenter
    @State private var selected: Article?

    
    var body: some View {
        List(presenter.articles) { article in
            ArticleView(article: article)
                .onTapGesture {
                    selected = article
                }
        }
        .listStyle(.plain)
        .sheet(item: $selected) { article in
            ExternalLinkView(url: article.articleURL)
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
    override func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        completion(.success(Article.previewData))
    }
}
#endif

