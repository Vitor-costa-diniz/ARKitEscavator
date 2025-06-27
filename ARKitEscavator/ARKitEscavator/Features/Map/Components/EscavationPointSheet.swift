//
//  EscavationPointSheet.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 25/06/25.
//

import SwiftUI

struct EscavationPointSheet: View {
    @State private var sheetHeight: CGFloat = 0
    @ScaledMetric private var scale: CGFloat = 1
    @StateObject var viewModel: MapViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 0) {
                Image(.simpleFrame)
                    .overlay {
                        Image(viewModel.selectedPoint?.objectImage ?? "")
                    }
                    .padding(.bottom, 16)
                
                Group {
                    Text(viewModel.selectedPoint?.name ?? "")
                        .font(.escavatorUI(.body1Regular))
                        .padding(.bottom, 7)
                    
                    Text("\(viewModel.selectedPoint?.address ?? "")\n")
                        .font(.escavatorUI(.bodyManjari4))
                    
                    Text("\(viewModel.selectedPoint?.shortDescription ?? "")")
                        .font(.escavatorUI(.bodyManjari4))
                }
                .fixedSize(horizontal: false, vertical: true)
                .foregroundStyle(.text)
                
                Button {
                    // Função para abrir parte de realidade aumentada
                } label: {
                    HStack(alignment: .firstTextBaseline, spacing: 10) {
                        Spacer()
                        
                        Image(.shovel)
                            .resizable()
                            .frame(width: 20 * scale, height: 20 * scale)
                            .offset(y: 4)
                        Text("Escavar")
                            .font(.escavatorUI(.headingManjari3))
                        
                        Spacer()
                    }
                    .foregroundStyle(Color.buttonText)
                    .padding(.vertical, 11)
                    .background {
                        (viewModel.canEscavate() ? Color.blueBackground : Color.gray.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 6))
                    }
                }
                .padding(.top, 25)
                .padding(.bottom, 2.7)
                .disabled(!viewModel.canEscavate())
                
                Button {
                    viewModel.openInMaps()
                } label: {
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
            }
            .dynamicSheetHeight(into: $sheetHeight)
            
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal, 20)
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(0)
        .presentationDetents([.height(sheetHeight + 50)])
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
            EscavationPointSheet(viewModel: .init())
        }
}
