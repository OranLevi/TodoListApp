//
//  AddView.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var textFiledText:String = ""
    
    @State var alertTitle:String = ""
    @State var isShowingAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something here...",text: $textFiledText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                
                Button {
                    saveButtonTap()
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Add an Item ")
        .alert(isPresented: $isShowingAlert, content: {
            Alert(title: Text(alertTitle))
        })
    }
    
    func saveButtonTap(){
        if textFiledText.count < 3 {
            alertTitle = "The new todo item must be at least 3 characters!"
            isShowingAlert.toggle()
        } else {
            listViewModel.addItem(title: textFiledText)
            presentationMode.wrappedValue.dismiss()
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }.environmentObject(ListViewModel())
    }
}
