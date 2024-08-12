//
//  ActorBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//

import SwiftUI

class myDataManager: ObservableObject {
    var data:[String] = []
    
    static let instance = myDataManager()
    private init(){ }
    
    
    private let queue = DispatchQueue(label:"com.hlwan.myDataManger")//some people call lock instead of queue
    
    
    func getRandomData(completionHandeler:@escaping (_ title:String?) -> ()){
        queue.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandeler(self.data.randomElement())
        }
    }
}


actor myActorDataManager: ObservableObject {
    var data:[String] = []
    
    static let instance = myActorDataManager()
    private init(){ }
    
    func getRandomData()-> String?{
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    nonisolated
    func getSavedData() -> String{ //We don't worry about data race in this function and await for the actor
        
//        let data = getRandomData()  this can't be done because nonisolated func can't access isolated values or func
        return "Some new Data"
    }
}

struct HomeView:View {
    let manager = myActorDataManager.instance
    @State var text:String = ""
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View{
        ZStack{
            Color.gray.opacity(0.8)
                .ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onAppear{
            let data = manager.getSavedData() //this one doesn't need to do await because it's nonIsolated
            //Actor are always isolated and if u want to acess the func or value of actor, u have to await
            Task{
                let data = await manager.data //this one need to do await because of the actor
            }
        }
        .onReceive(timer) { _ in
            Task{
                if let data = await manager.getRandomData(){
                    await MainActor.run {
                        self.text = data
                    }
                }
                    
            }
//            DispatchQueue.global(qos:.background).async{
//                manager.getRandomData { title in
//                    if let data = title{
//                        DispatchQueue.main.async{
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}

struct BrowseView:View {
    let manager = myActorDataManager.instance
    @State var text:String = ""
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View{
        ZStack{
            Color.yellow.opacity(0.8)
                .ignoresSafeArea()
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            Task{
                if let data = await manager.getRandomData(){
                    await MainActor.run {
                        self.text = data
                    }
                }
                    
            }
//            DispatchQueue.global(qos:.background).async{
//                manager.getRandomData { title in
//                    if let data = title{
//                        DispatchQueue.main.async{
//                            self.text = data
//                        }
//                    }
//                }
//            }
        }
    }
}



struct ActorBootcamp: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    ActorBootcamp()
}
