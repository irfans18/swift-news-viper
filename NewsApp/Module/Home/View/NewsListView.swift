//
//  NewsListView.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var presenter: NewsPresenter
    @State private var selected: Article?
    
    var body: some View {
        NavigationView {
            Group {
                switch presenter.phase {
                case .loading:
                    ProgressView()
                case .empty:
                    Text("No articles available.")
                case .success(let articles):
                    List(articles) { article in
                        ArticleView(article: article)
                            .onTapGesture {
                                selected = article
                            }
                    }
                    .listStyle(.plain)
                    .sheet(item: $selected) { article in
                        ExternalLinkView(url: article.articleURL)
                    }
                    .navigationTitle(presenter.selectedCategory.text)
                    .navigationBarItems(trailing: menu)
                    .searchable(text: $presenter.searchText)
                case .failure(let error):
                    Text("Failed to load articles: \(error.localizedDescription)")
                }
            }
            .refreshable{
                self.presenter.loadArticles()
            }
            .onChange(of: presenter.selectedCategory) { _ in
                presenter.loadArticles()
            }
            .onChange(of: presenter.searchText) { _ in
                presenter.loadArticles()
            }
            .onAppear {
                self.presenter.loadArticles()
            }
            
        }
    }
    
    private var menu : some View{
        Menu{
            Picker("Category", selection: $presenter.selectedCategory){
                ForEach(Category.allCases){
                    Text($0.text).tag($0)
                }
            }
        }label: {
            Image(systemName: "menubar.rectangle")
                .imageScale(.large)
        }
    }
}


#if DEBUG
struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockPresenter = NewsPresenter(interactor: MockNewsListInteractor())
        return NewsListView(presenter: mockPresenter)
    }
}

class MockNewsListInteractor: NewsListInteractor {
    override func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {
        completion(.success(Article.previewData))
    }
}
#endif

