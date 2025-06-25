//
//  EscavationPointSheet.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 25/06/25.
//

import SwiftUI

struct EscavationPointSheet: View {
    let escavationPoint: EscavationPoint
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(.simpleFrame)
                .overlay {
                    Image(escavationPoint.objectImage)
                }
                .padding(.bottom, 16)
            
            Group {
                Text(escavationPoint.name)
                    .font(.escavatorUI(.body1Regular))
                    .padding(.bottom, 7)
                
                Text("\(escavationPoint.address)\n")
                    .font(.escavatorUI(.bodyManjari4))
                
                Text(escavationPoint.shortDescription)
                    .font(.escavatorUI(.bodyManjari4))
            }
            .foregroundStyle(.text)
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal, 20)
        .presentationDetents([.fraction(0.65)])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(0)
        .presentationBackground {
            SheetShape()
                .fill(Color(.buttonOverlay))
        }
    }
}

#Preview {
    Text("adada")
        .background {
            Color.black
                .frame(width: 400, height: 1000)
        }
        .sheet(isPresented: .constant(true)) {
            EscavationPointSheet(escavationPoint: .init())
        }
}
