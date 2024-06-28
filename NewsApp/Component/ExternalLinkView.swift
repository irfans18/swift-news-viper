//
//  ExternalLinkView.swift
//  NewsApp
//
//  Created by MACBOOK on 28/06/24.
//

import SwiftUI
import SafariServices

struct ExternalLinkView: UIViewControllerRepresentable{
    
    let url: URL
    
    func makeUIViewController(context: Context)-> some SFSafariViewController{
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}


//struct ExternalLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExternalLinkView(url: URL(string: "https://google.com")!)
//    }
//}
