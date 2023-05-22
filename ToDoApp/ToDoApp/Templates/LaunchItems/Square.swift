//
//  Square.swift
//  ToDoApp
//
//  Created by Майлс on 08.02.2023.
//

import SwiftUI

struct Square: View {
    
    let color: Color
    
    var body: some View {
        Rectangle()
            .frame(width: 50, height: 50)
            .foregroundColor(color)
    }
}

struct Square_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Square(color: .red)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .padding()
            
            Square(color: .red)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
