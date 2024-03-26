//
//  View.swift
//  ChocKit
//
//  Created by Alex Vaiman on 06/03/2024.
//
import SwiftUI

typealias ViewTraitKey = _ViewTraitKey
typealias VariadicView = _VariadicView


struct HelperMultiViewRoot<Result: View>: VariadicView.MultiViewRoot {
    var _body: (VariadicView.Children) -> Result

    func body(children: VariadicView.Children) -> some View {
        _body(children)
    }
}

struct HelperUnaryViewRoot<Result: View>: VariadicView.UnaryViewRoot {
    var _body: (VariadicView.Children) -> Result

    func body(children: VariadicView.Children) -> some View {
        _body(children)
    }
}


extension View {
    func variadicMultiViewRoot<R: View>(@ViewBuilder process: @escaping (VariadicView.Children) -> R) -> some View {
        VariadicView.Tree(HelperMultiViewRoot(_body: process), content: { self })
    }
    
    func variadicUnaryViewRoot<R: View>(@ViewBuilder process: @escaping (VariadicView.Children) -> R) -> some View {
        VariadicView.Tree(HelperUnaryViewRoot(_body: process), content: { self })
    }
}
