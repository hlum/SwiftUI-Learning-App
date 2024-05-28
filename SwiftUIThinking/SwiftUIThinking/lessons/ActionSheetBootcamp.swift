//
//  ActionSheetBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/05/28.
//

import SwiftUI

struct ActionSheetBootcamp: View {
    @State var showActionSheet: Bool = false
    @State var actionSheetOption:ActionSheetOptions = .isOtherPost
    
    enum ActionSheetOptions{
        case isMyPost
        case isOtherPost
    }
    
    
    var body: some View {
        
        VStack {
            HStack{
                Circle()
                    .frame(width:30,height:30)
                Text("@username")
                Spacer()
                Button("\(actionSheetOption)"){
                    if actionSheetOption == .isMyPost{
                        actionSheetOption = .isOtherPost
                    }else{
                        actionSheetOption = .isMyPost
                    }
                }
                Button(action: {
                    showActionSheet.toggle()
                }, label: {
                    Image(systemName:"ellipsis")
                })
                .accentColor(.primary)
            }
            .padding(.horizontal)
            Image("ImgGf")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 500)
                .blur(radius: 10.0)
            
            ButtonCodePreview(code: .ActionSheet)
        }
//        .padding()
        .actionSheet(isPresented: $showActionSheet, content: getActionSheet)
    }
    func getActionSheet() -> ActionSheet{
        let editButton : ActionSheet.Button = .default(Text("Edit")){
            
        }
        
        let shareButton : ActionSheet.Button = .default(Text("Share")){
            
        }
        let reportButton : ActionSheet.Button = .destructive(Text("Report")){
            
        }
        let deleteButton : ActionSheet.Button = .destructive(Text("Delete")){
            
        }
        let cancelButton : ActionSheet.Button = .cancel()
        
        let title = Text("What would u like to do")
        
        
        switch actionSheetOption{
        case .isMyPost:
            return ActionSheet(title: title, message: nil, buttons: [editButton,shareButton,deleteButton,reportButton,cancelButton])
        case .isOtherPost:
            return ActionSheet(title: title, message: nil, buttons: [shareButton,reportButton,cancelButton])
            
        }
        
//        let button1 :ActionSheet.Button = .default(Text("Default"))
//        let button2 :ActionSheet.Button = .destructive(Text("Destructive"))
//        let button3 :ActionSheet.Button = .cancel(Text("Cancel"))
//        return ActionSheet(
//            title: Text("This is title"),
//            message: Text("This is message"),
//            buttons: [button1,button2,button3]
//        )
    }
}

#Preview {
    ActionSheetBootcamp()
}
