//
//  NoItemsView.swift
//  TodoList
//
//  Created by Oran Levi on 05/05/2023.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
        
        VStack(spacing: 40){
            Text("No items")
                .font(.title)
                .fontWeight(.semibold)
            NavigationLink(destination: AddView()) {
                Text("Add Something")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(animate ? Color.red : Color.accentColor)
                    .cornerRadius(10)
            }
            .padding(.horizontal, animate ? 30 : 50)
            .shadow(
                color: animate ? Color.red.opacity(0.7) : Color.accentColor.opacity(0.7),
                radius: animate ? 30 : 10
            )
            .scaleEffect(animate ? 1.1 : 1.0)
        }
        .frame(maxWidth: 400)
        .padding()
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation(){
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ){
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
        }
        .navigationTitle("Title")
        
    }
}
