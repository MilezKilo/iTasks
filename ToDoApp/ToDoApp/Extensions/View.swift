//
//  View.swift
//  ToDoApp
//
//  Created by Майлс on 27.04.2023.
//

import SwiftUI

//MARK: Custom Font Extension
enum Ubuntu {
    case light
    case bold
    case medium
    case regular
    
    var weight: Font.Weight {
        switch self {
        case .light:
            return .light
        case .bold:
            return .bold
        case .medium:
            return .medium
        case .regular:
            return .regular
        }
    }
}

//MARK: - VIEW EXTENSION
extension View {
    /// - Custom fonts
    func ubuntu(_ size: CGFloat, _ weight: Ubuntu) -> some View {
        self
            .font(.custom("Ubuntu", size: size))
            .fontWeight(weight.weight)
    }
    
    /// - New horizontal and vertical alignments
    func hAlignment(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    func vAlignment(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
}
