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
                    .padding(.bottom, 17)
                
                Text("\(escavationPoint.shortDescription)")
                    .font(.escavatorUI(.bodyManjari4))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundStyle(.text)
            
            Button {} label: {
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Spacer()
                    
                    Image(.shovel)
                        .offset(y: 4)
                    Text("Escavar")
                        .font(.escavatorUI(.headingManjari3))
                    
                    Spacer()
                }
                .foregroundStyle(Color.buttonText)
                .padding(.vertical, 11)
                .background {
                    Color.blueBackground
                        .clipShape(.rect(cornerRadius: 6))
                }
            }
            .padding(.top, 25)
            .padding(.bottom, 2.7)
            
            Button {} label: {
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Spacer()
                    
                    Image(systemName: "mappin.and.ellipse")
                    Text("Navegar")
                    
                    Spacer()
                }
                .font(.escavatorUI(.headingManjari3))
                .foregroundStyle(Color.buttonText)
                .padding(.vertical, 11)
                .background {
                    Color.greenBackground
                        .clipShape(.rect(cornerRadius: 6))
                }
            }
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal, 20)
        .presentationDetents([.fraction(0.69)])
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
