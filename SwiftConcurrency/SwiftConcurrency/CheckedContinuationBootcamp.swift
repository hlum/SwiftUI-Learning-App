//
//  CheckedContinuationBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//

import SwiftUI

class CheckedContinuationBootcampNetworkManager: ObservableObject {
    
    func getData(url:URL) async throws -> Data {
        do {
            let (data,_) = try await URLSession.shared.data(from:url,delegate:nil)
            return data
        } catch {
            throw error
        }
    }
    
    
    func getData2(url:URL) async throws -> Data{
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in //need to resume at least once or the app will crash
                if let data = data{
                    continuation.resume(returning: data)
                }else if let error = error {
                    continuation.resume(throwing:error)
                }else{
                    continuation.resume(throwing: URLError(.badServerResponse))
                }
            }.resume()
        }
    }
    
    func getHeartImageFromDatabase(completionHandler: @escaping (_ image:UIImage)->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 4){
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDatabase2() async-> UIImage{
        return await withCheckedContinuation { continuation in
//            DispatchQueue.main.asyncAfter(deadline: .now()+4.0){
//                if let image = UIImage(systemName: "heart.fill"){
//                    continuation.resume(returning:image)
//                }
//                
//            }
            getHeartImageFromDatabase { image in
                continuation.resume(returning: image)
            }
            
        }
    }
}

class CheckedContinuationBootcampViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let networkManager = CheckedContinuationBootcampNetworkManager()
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/200") else {return}
        do {
            let data = try await networkManager.getData2(url: url)
            if let image = UIImage(data: data){
                await MainActor.run{
                    self.image = image
                }
            }

        } catch{
            print(error.localizedDescription)
        }
    }
    
    
    func getHeartImage(){
        networkManager.getHeartImageFromDatabase {[weak self] image in
            self?.image = image
        }
    }
    
    func getHeartImage2() async{
        self.image = await networkManager.getHeartImageFromDatabase2()
    }
    
}

struct CheckedContinuationBootcamp: View {
    @StateObject var viewModel = CheckedContinuationBootcampViewModel()
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width:200,height: 200)
            }
        }
        .task {
//           await viewModel.getImage()
                await viewModel.getHeartImage2()
        }
    }
}

#Preview {
    CheckedContinuationBootcamp()
}
