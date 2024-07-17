//
//  DownloadWithCombine.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/07/17.
//https://jsonplaceholder.typicode.com/posts

import SwiftUI
import Combine


struct PostModel : Identifiable,Codable {
    let userID, id: Int
    let title, body: String
}

class DownloadWithCombineViewModel:ObservableObject{
    @Published var posts : [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    
    init(){
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/posts")else{return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos:.background))
            .receive(on:DispatchQueue.main)
            .tryMap { (data,response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                   return data
            }
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                print("Completion \(completion)")
            } receiveValue: { [weak self] returnedData in
                self?.posts = returnedData
            }
            .store(in: &cancellables)

    }
    
    }

struct DownloadWithCombine: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    var body: some View {
        List{
            ForEach(vm.posts) { post in
                VStack{
                    Text(post.title)
                        .font(.title)
                    Text(post.body)
                        .font(.body)
                }
            }
        }
    }
}

#Preview {
    DownloadWithCombine()
}
