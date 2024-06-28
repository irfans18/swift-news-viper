//
//  ArticleView.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    var body: some View {
        HStack{
            AsyncImage(url: article.imageURL){
                phase in
                switch phase {
                case .empty:
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    HStack{
                        Spacer()
                        Image(systemName: "photo")
                        Spacer()
                    }
                @unknown default:
                    fatalError()
                }
            }
            .frame(width: 200, height: 150)
            .clipped()
            VStack{
                Text(article.title)
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.bottom,2)
                    .padding(.top,16)
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(2)
                    .padding(.bottom,4)
                Spacer()
                Text(article.captionText)
                    .font(.caption)
                    .padding(.bottom,8)
            }
        }

    }
}

//struct ArticleView_Previews: PreviewProvider {
//    static var previews: some View {
//        List{
//            ArticleView(article: .previewData[0])
//                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
//        }
//        .listStyle(.plain)
//    }
//}
