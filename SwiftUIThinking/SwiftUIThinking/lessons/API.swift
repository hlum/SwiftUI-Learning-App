import SwiftUI

struct Comment: Codable {
    var id: Int
    var name: String
    var email: String
    var body: String
}

class CommentLoader: ObservableObject {
    @Published var comments = [Comment]()

    init() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Invalid data")
                return
            }

            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comment].self, from: data)
                DispatchQueue.main.async {
                    self.comments = comments
                }
            } catch let error {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct API: View {
    @ObservedObject var commentLoader = CommentLoader()

    var body: some View {
        NavigationView {
            List(commentLoader.comments, id: \.id) { comment in
                VStack(alignment: .leading, spacing: 8) {
                    Text(comment.name)
                        .font(.headline)
                    Text(comment.body)
                        .font(.subheadline)
                    Text(comment.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Comment section")
        }
    }
}
#Preview{
    API()
}
