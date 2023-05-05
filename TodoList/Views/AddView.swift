//
//  AddView.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import SwiftUI

struct AddView: View {
    
    @State var textFiledText:String = ""
    
    var body: some View {
        ScrollView{
            VStack {
                TextField("Type something here...",text: $textFiledText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                
                Button {
                    
                } label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }

            }.padding()
        }.navigationTitle("Add an Item ")
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddView()
        }
    }
}
