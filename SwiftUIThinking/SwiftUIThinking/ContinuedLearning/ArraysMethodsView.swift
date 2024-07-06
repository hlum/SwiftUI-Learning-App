//
//  ArraysMethodsView.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/22.
//

import SwiftUI

struct UserModel: Identifiable{
    let id = UUID().uuidString
    let name : String
    let point : Int
    let isVerified : Bool
}

class ArrayModificationViewModel: ObservableObject{
    
    @Published var dataArray : [UserModel] = []
    @Published var filteredArray : [UserModel] = []
    @Published var mappedArray : [String] = []
    
    init(){
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers(){
        let user1 = UserModel(name: "nil", point: 5, isVerified: true)
        let user2 = UserModel(name: "fasd", point: 3, isVerified: false)
        let user3 = UserModel(name: "nil", point: 1, isVerified: true)
        let user4 = UserModel(name: "Hln", point: 2, isVerified: true)
        let user5 = UserModel(name: "sdf", point: 6, isVerified: false)
        
        self.dataArray.append(contentsOf:[
                                user1,
                                user2,
                                user3,
                                user4,
                                user5
        ]
                              
        )
    }
    
    func updateFilteredArray(){
        //sort
        /*
//        filteredArray = dataArray.sorted(by: { user1, user2 in
//            return user1.point > user2.point
//        })
//        
//      shorter version
//        filteredArray = dataArray.sorted(by: {$0.point > $1.point})
*/
        //filter
        /**
         filteredArray = dataArray.filter({ user in
             user.name.contains("H")
         })
         
         
         filteredArray = dataArray.filter({$0.isVerified})
         **/
        //map
        /*
        mappedArray = dataArray.map({ user -> String in
            user.name ?? "no username"
        })
        mappedArray  = dataArray.map({$0.name ?? "no username"})
        
//        mappedArray = dataArray.compactMap({ user -> String? in
//            user.name
//        })
        
        mappedArray  = dataArray.compactMap({$0.name})
        */
        
        let sort = dataArray.sorted(by: {$0.point > $1.point})
        let filter = dataArray.filter({$0.isVerified})
        let map  = dataArray.map({$0.name})
        
        
        mappedArray = dataArray
                    .sorted(by: {$0.point > $1.point})
                    .filter({$0.isVerified})
                    .map({$0.name})
                    
            
    }
    
}

struct ArraysMethodsView: View {
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView{
            
//            VStack(spacing:10){
//                
//                ForEach(vm.mappedArray, id: \.self) { name in
//                    Text(name)
//                        .font(.title)
//                }
                ForEach(vm.filteredArray) { user in
                    VStack(alignment: .leading){
                        
                        Text(user.name)
                            .font(.headline)
                        
                        HStack{
                            Text("Points: \(user.point)")
                            Spacer()
                            
                            if user.isVerified{
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.cornerRadius(10))
                }
            
        }.padding()
    }
}

#Preview {
    ArraysMethodsView()
}
