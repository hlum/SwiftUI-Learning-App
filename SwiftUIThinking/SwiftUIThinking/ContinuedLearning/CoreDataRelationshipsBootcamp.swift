//
//  CoreDataRelationshipsBootcamp.swift
//  SwiftUIThinking
//
//  Created by Hlwan Aung Phyo on 2024/06/25.
//

import SwiftUI
import CoreData

class CoreDataManager{
    static let instance = CoreDataManager()
    let container:NSPersistentContainer
    let context : NSManagedObjectContext
    
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Error loading Core Data. \(error)")
            }
            
        }
        context = container.viewContext
        
    }
    
    
    func save(){
        do{
            try context.save()
            print("saved successfully")
        }catch let error{
            print("error saving. \(error.localizedDescription)")
        }
        
    }
}

class CoreDataRelationshipsViewModel : ObservableObject{
    
    init(){
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    let manager = CoreDataManager.instance
    
    @Published var businesses : [BusinessEntity] = []
    @Published var departments : [DepartmentEntity] = []
    @Published var employees : [EmployeeEntity] = []
    
    func getBusinesses(){
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        do{
            businesses = try manager.context.fetch(request)
        }catch let error{
            print("Error Fetching Data. \(error.localizedDescription)")
        }
    }
    func getDepartments(){
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        do{
            departments = try manager.context.fetch(request)
        }catch let error{
            print("Error Fetching Data. \(error.localizedDescription)")
        }
    }
    func getEmployees(){
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        do{
            employees = try manager.context.fetch(request)
        }catch let error{
            print("Error Fetching Data. \(error.localizedDescription)")
        }
    }

    
    
    func addBusiness(){
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        
        
        //add exisiting departments to the new business
        newBusiness.department = []
        
        
        //add exisiting employees to the new business
        newBusiness.employees = []
        
        
        //add new Business to exisiting department
        //        newBusiness.addToDepartment(DepartmentEntity)
        
        //add new business to existing employee
        //        newBusiness.addToEmployees(T##value: EmployeeEntity##EmployeeEntity)
        
        save()
    }
    
    func addDepartment(){
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing Department"
        newDepartment.businesses = [businesses[0]]
        
        save()
        
    }
    
    func addEmployees(){
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 20
        newEmployee.dateJoined = Date()
        newEmployee.name = "Hlwan"
        newEmployee.business = businesses[0]
        newEmployee.department = departments[0]
        save()
        
    }
    
    func save(){
        
        businesses.removeAll()
        departments.removeAll()
        employees.removeAll()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.manager.save()
            print("Saved")
            self.getBusinesses()
            self.getDepartments()
            self.getEmployees()
            
        }
    }
}

struct CoreDataRelationshipsBootcamp: View {
    
    
    
    @StateObject var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:20){
                    Button {
                        vm.save()
                    } label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.cornerRadius(10))
                    }
                    ScrollView(.horizontal,showsIndicators: true){
                        HStack(alignment:.top){
                            ForEach(vm.businesses){business in
                                BusinessView(entity: business)
                                
                            }
                        }
                    }
                    ScrollView(.horizontal,showsIndicators: true){
                        HStack(alignment:.top){
                            ForEach(vm.departments){department in
                                DepartmentView(entity: department)
                                
                            }
                        }
                    }
                    
                    ScrollView(.horizontal,showsIndicators: true){
                        HStack(alignment:.top){
                            ForEach(vm.employees){employee in
                                EmployeeView(entity: employee)
                                
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Relationships")
        }
    }
}


struct BusinessView: View{
    let entity  : BusinessEntity
    var body: some View {
        
        VStack(spacing:20){
            Text("Name :\(entity.name ?? "")")
                .bold()
            
            if let departments = entity.department?.allObjects as? [DepartmentEntity]{
                Text("Departments : ")
                    .bold()
                ForEach(departments){department in
                    Text(department.name ?? "")
                }
            }
            
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees : ")
                    .bold()
                ForEach(employees){employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius:10)
    }
}

struct DepartmentView: View{
    let entity  : DepartmentEntity
    var body: some View {
        
        VStack(spacing:20){
            Text("Name :\(entity.name ?? "")")
                .bold()
            
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity]{
                Text("Businesses : ")
                    .bold()
                ForEach(businesses){business in
                    Text(business.name ?? "")
                }
            }
            
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity]{
                Text("Employees : ")
                    .bold()
                ForEach(employees){employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.green.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius:10)
    }
}

struct EmployeeView: View{
    let entity  : EmployeeEntity
    
    var body: some View {
        
        VStack(spacing:20){
            Text("Name :\(entity.name ?? "")")
                .bold()
            
            Text("Business :")
                .bold()
            
            Text(entity.business?.name ?? "")
            
            Text("Department :")
                .bold()
            
            Text(entity.department?.name ?? "")
            
        }
        .padding()
        .frame(maxWidth: 300,alignment: .leading)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius:10)
    }
}

#Preview {
    CoreDataRelationshipsBootcamp()
}
