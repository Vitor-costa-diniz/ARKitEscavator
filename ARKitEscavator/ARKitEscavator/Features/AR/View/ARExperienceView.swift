//
//  ARExperienceView.swift
//  ARKitEscavator
//
//  Created by Kelly Letícia Nascimento de Morais on 22/06/25.
//

import SwiftUI

struct ARExperienceView: View {
    @Environment(\.presentationMode) private var presentationMode
    let site: EscavationSite

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ARViewContainer(site: site)
                .edgesIgnoringSafeArea(.all)

            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .padding()
            }
        }
    }
}
