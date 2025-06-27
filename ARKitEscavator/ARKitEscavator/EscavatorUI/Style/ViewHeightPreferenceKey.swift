//
//  ViewHeightPreferenceKey.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 26/06/25.
//

import SwiftUI

struct ViewHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct SheetHeightModifier: ViewModifier {
    @Binding var height: CGFloat

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ViewHeightPreferenceKey.self, value: proxy.size.height)
                }
            )
            .onPreferenceChange(ViewHeightPreferenceKey.self) { value in
                height = value
            }
    }
}

extension View {
    func dynamicSheetHeight(into binding: Binding<CGFloat>) -> some View {
        self.modifier(SheetHeightModifier(height: binding))
    }
}
