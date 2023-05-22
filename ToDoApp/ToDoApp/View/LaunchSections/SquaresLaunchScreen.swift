//
//  SquaresLaunchScreen.swift
//  ToDoApp
//
//  Created by Майлс on 08.02.2023.
//

import SwiftUI

//ALL SQUARES ENUM
enum AllSquares: CaseIterable {
    
    static var indexOffset: Int = 0
    
    case one, two, three, clear
    
    var view: AnyView {
        switch self {
        case .one:
            return AnyView(Square(color: .yellow))
        case .two:
            return AnyView(Square(color: .blue))
        case .three:
            return AnyView(Square(color: .red))
        default:
            return AnyView(EmptyView())
        }
    }
    
}

//SQUARES ANIMATION VIEW
struct SquaresLaunchScreen: View {
    
    @State private var allBlocks = AllSquares.allCases
    @State private var allIndices: [(CGFloat, CGFloat, Double, Bool)] = [
        (30, 30, 5, false), //YELLOW true
        (-30, 30, 3, false), //BLUE
        (-30, -30, 1, false), //RED
        (30, -30, 2, false), //EMPTY true
    ]
    @State private var currentIndex: Int = 2
    @Binding var showLaunchScreen: Bool
    
    var body: some View {
        VStack(spacing: 75) {
            Text("Добро пожаловать!")
                .font(.largeTitle)
                .bold()
            ZStack {
                ForEach(0 ..< allBlocks.count, id: \.self) { index in
                    square(index: index)
                }
            }
            Text("Загрузка данных...")
                .font(.callout)
                .bold()
        }
        .onAppear {
            withAnimation { rotate() }
            changeStatus()
        }
    }
    

}

//MARK: - EXTENSION WITH METHODS
extension SquaresLaunchScreen {
    /// - Returns square based on template square
    private func square(index: Int) -> some View {
        let offset = allIndices[index]
        return allBlocks[index].view
            .offset(x: offset.0, y: offset.1)
            .zIndex(offset.2)
    }
    /// - Func that rotate square
    private func rotate() {
        let clearPosition = allIndices[3]
        
        allIndices[3] = allIndices[currentIndex]
        allIndices[currentIndex] = clearPosition
        
        currentIndex = currentIndex - 1
        
        if currentIndex == -1 {
            currentIndex = 2
        }
        if allIndices[currentIndex].3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.easeIn(duration: 0.3)) {
                    rotate()
                }
            }
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                withAnimation(.easeIn(duration: 0.4)) {
                    rotate()
                }
            }
        }
    }
    /// - Bool func  changing status of square template
    private func changeStatus() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation(.linear) {
                self.showLaunchScreen = false
            }
        }
    }
}

//MARK: - PREVIEW
struct SquaresLaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            SquaresLaunchScreen(showLaunchScreen: .constant(true))
                .preferredColorScheme(.light)
            
            SquaresLaunchScreen(showLaunchScreen: .constant(true))
                .preferredColorScheme(.dark)
        }
    }
}
