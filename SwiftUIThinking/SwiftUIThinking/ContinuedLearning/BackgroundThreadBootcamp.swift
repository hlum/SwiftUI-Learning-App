//
//  BackgroundThreadBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/07/06.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject{
    @Published var dataArray : [String] = []
    
    
    func fetchData(){
        
        DispatchQueue.global(qos: .background).async{
            let newData = self.downloadData()
        
            print("Check1 : \(Thread.isMainThread)")
            print("Check1 : \(Thread.current)")
            DispatchQueue.main.async{
                self.dataArray = newData
                print("Check2 : \(Thread.isMainThread)")
                print("Check2 : \(Thread.current)")

            }

        }
    }
    
    
    private func downloadData() -> [String]{
        var data :[String] = []
        for x in 0..<100{
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    @StateObject var vm = BackgroundThreadViewModel()
    var body: some View {
        ScrollView{
            LazyVStack(spacing:10){
                Text("Load Data")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadBootcamp()
}
