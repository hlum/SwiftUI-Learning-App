//
//  LongPressGestureBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/21.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State var isCompleted:Bool = false
    @State var isSuccess: Bool = false
    var body: some View {
        VStack{
            Rectangle()
                .fill(isSuccess ? .green : .blue)
                .frame(maxWidth: isCompleted ? .infinity : 0)
                .frame(height:55)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Click here")
                    .foregroundColor(.white)
                    .padding()
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0,maximumDistance: 50){ (isPressing) in
                        //start of the press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration:1.0)){
                                isCompleted = true
                            }
                        }else{
                            DispatchQueue.main.asyncAfter(deadline:.now() + 0.1){
                                if !isSuccess {
                                    withAnimation(.easeInOut){
                                        isCompleted = false
                                    }
                                }
                            }
                        }
                    }perform:{
                        //at the min duration
                        withAnimation(.easeInOut(duration: 1.0)){
                            isSuccess = true
                        }
                    }
            }
            
            
            Text("Reset")
                .foregroundColor(.white)
                .padding()
                .background(.black)
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation(.easeInOut){
                        isCompleted = false
                        isSuccess = false
                    }
                }
            

        }
        
        
        
        
        
        
        
        
//        Text(isCompleted ? "Completed" : "Not Completed")
//            .padding()
//            .padding(.horizontal)
//            .background(isCompleted ? Color.green : Color.gray)
//            .cornerRadius(10)
////            .onTapGesture {
////                isCompleted.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 5.0,maximumDistance: 1) {
//                isCompleted.toggle()
//            }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
