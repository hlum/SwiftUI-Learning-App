//
//  StructClassActorBootcamp.swift
//  SwiftConcurrency
//
//  Created by Hlwan Aung Phyo on 8/12/24.
//







/*
 Value Types:
 - Struct,Enum,String,Int,etc.
 - Stored in the Stack
 - Faster
 - Thread Safe
 - When you assign or pass value type, a new copy of data is created.
 
 REFERENCE TYPES:
 - Class,Function,Actor
 - Stored in the Heap
 - Slower, but synchronized
 - Not Thread Safe
 - When you assign or pass reference type, a new reference to original instance will be created(pointer)
 
 --------------------------------------------------------------------
 
 MEMORY TYPES:
 
 STACK:
 - Stored Value Types
 - Variables allocated on the stack are stored directly to the memory, and acess to this memory is very fast.
 - Each thread has it's own Stack
 
 
 
 HEAP:
 - Stored Reference Types
 - Share across Threads!!!
 
 
 --------------------------------------------------------------------
 
 STRUCT:
 - Based on values
 - Can be mutated
 - Stored in Stack!
 
 
 CLASS:
 - Based on references[INSTANCES]
 - Stored in the HEAP!
 - Can inherit from other classes
 
 
 ACTOR:
 - Same as CLASS, but thread safe
 
 
 --------------------------------------------------------------------
 
 WHEN TO USE WHAT
 
 STRUCTS : Data Models,Views
 CLASS : ViewModel
 ACTOR : Shared 'Manager' and 'Data Store'
 
 
 */
import SwiftUI




struct StructClassActorBootcamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                structTest1()
                printDivider()
                classTest1()
                structTest2()
                classTest2()
                actorTest1()
            }
    }
}




extension StructClassActorBootcamp{
    private func runTest(){
        print("Test Started")
    }
    
    private func printDivider(){
        print("""
-----------------------------------------------
""")
    }
    
    private func structTest1(){
        print("Struct Test 1")
        let objectA = MyStruct(title: "Starting Title!")
        print("ObjectA :",objectA.title)
        
        
        print("Pass the value of objectA to objectB")
        //This is the difference between class and struct.Just pass the value not reference.
        
        var objectB = objectA
        print("ObjectB : ",objectB.title)
        
        objectB.title = "Second Title!"
        print("ObjectB title Changed")
        
        print("ObjectA :",objectA.title)
        print("ObjectB : ",objectB.title)
        
    }
    private func classTest1(){
        print("Class Test 1")
        let objectA = MyClass(title:"Starting title!")
        print("ObjectA :",objectA.title)
        
        print("Pass the REFERENCE of objectA to objectB")
        let objectB = objectA
        print("ObjectB : ",objectB.title)
        
        
        objectB.title = "Second Title!"
        print("ObjectB title Changed")
        
        print("ObjectA :",objectA.title)
        print("ObjectB : ",objectB.title)

    }
    private func actorTest1() {
        Task{
            print("Actor Test 1")
            let objectA = MyActor(title:"Starting title!")
            await print("ObjectA :",objectA.title)
            
            print("Pass the REFERENCE of objectA to objectB")
            let objectB = objectA
            await print("ObjectB : ",objectB.title)
            
            
            await objectB.updateTitle(newTitle:"Second Title!")
            print("ObjectB title Changed")
            
            await print("ObjectA :",objectA.title)
            await print("ObjectB : ",objectB.title)
        }

    }
}
struct MyStruct{
    var title:String
}

// Immutable Struct
struct CustomStruct{
    let title : String
    
    func updateTitle(newTitle:String) -> CustomStruct{
        CustomStruct(title: newTitle)
    }
}

//Mutating Struct
struct MutatingStruct{
    var title : String
    
    mutating func updateTitle(newTitle:String){//creating a completely new struct
        title = newTitle
    }
}


extension StructClassActorBootcamp{
    private func structTest2(){
        print("Struct Test 2")
        var struct1 = MyStruct(title: "Title 1")
        print("Struct1: ",struct1.title)
        struct1.title = "Title 2"
        print("Struct1 :",struct1.title)
        
        var struct2 = CustomStruct(title: "Title 1")
        print("Struct2: ",struct2.title)
        struct2 = CustomStruct(title:"Title 2")
        print("Struct2: ",struct2.title)
        
        var struct3 = CustomStruct(title: "Title 1")
        print("Struct3: ",struct3.title)
        struct3 = struct3.updateTitle(newTitle: "Title 2")//This is returning a new struct object
        print("Struct3: ",struct3.title)
        
        var struct4 = MutatingStruct(title: "Title 1")
        print("Struct4: ",struct4.title)
        struct4.updateTitle(newTitle: "Title 2")//This is mutating the origin struct object
        print("Struct4: ",struct4.title)
        
    }
}

class MyClass{
    var title:String
    
    init(title:String){
        self.title = title
    }
    
    func updateTitle(newTitle:String){//creating a completely new struct
        title = newTitle
    }

}


actor MyActor{
    var title:String
    
    init(title:String){
        self.title = title
    }
    
    func updateTitle(newTitle:String){//creating a completely new struct
        title = newTitle
    }

}


extension StructClassActorBootcamp{
    private func classTest2(){
        print("Class Test 2")
        
        let class1 = MyClass(title: "Title 1")
        print("Class1: ",class1.title)
        class1.title = "Title 2"
        print("Class1: ",class1.title)
        
        let class2 = MyClass(title: "Title 1")
        print("Class2: ",class2.title)
        class2.updateTitle(newTitle:"Title 2")
        print("Class1: ",class2.title)
        
    }
}


