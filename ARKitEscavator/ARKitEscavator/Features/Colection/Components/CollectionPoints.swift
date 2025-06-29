//
//  CollectionPoints.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 28/06/25.
//

import SwiftUI

struct CollectionPoints: View {
    let point: MajorSite
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Image(.collectionSprayFrame)
                .offset(x: -30, y: -5)
                .rotationEffect(Angle(degrees: -10))
            
            HStack {
                Image(point.image ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 114, height: 119)
                    .clipped()
                    .mask(
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 114, height: 119)
                    )
                    .background {
                        Image(.doubleFrame)
                            .rotationEffect(Angle(degrees: -10))
                    }
                    .overlay {
                        SmalLabelComponent(text: "0/4", colorType: .green)
                            .offset(x: -5, y: -69)
                            .rotationEffect(Angle(degrees: -33))
                    }
                    .padding(.leading, 14)
                
                Spacer()
                
                VStack {
                    Text(point.name)
                        .font(.escavatorUI(.body3Regular))
                        .foregroundStyle(.buttonIcon)
                    
                    Button { action() } label: {
                        Text("Ver mais")
                            .foregroundStyle(.buttonOverlay)
                            .font(.escavatorUI(.headingManjari3))
                            .padding(.horizontal, 34.5)
                            .padding(.top, 4)
                            .padding(.vertical, 11)
                            .background {
                                Color.blueBackground
                                    .clipShape(.rect(cornerRadius: 6))
                            }
                    }

                }
            }
        }
    }
}

#Preview {
    CollectionPoints(point: .init()) {}
        .padding(.horizontal, 30)
}
