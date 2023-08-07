//
//  Planet.swift
//  SolarSystem
//
//  Created by Zijun Ye
//

import SwiftUI
import RealityKit
import RealityKitContent

private let modelDepth: Double = 200

/// The list of 3D models to display in the winow.
private enum Item: String, CaseIterable, Identifiable {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

/// The module detail content that's specific to the orbit module.
struct Planet: View {
    @State private var selection: Item = .Earth

    var body: some View {
        VStack(spacing: 100) {
            Color.clear
                .overlay {
                    ItemView(item: .Mercury)
                        .opacity(selection == .Mercury ? 1 : 0)
                }
                .overlay {
                    ItemView(item: .Venus)
                        .opacity(selection == .Venus ? 1 : 0)
                }
                .overlay {
                    ItemView(item: .Earth)
                        .opacity(selection == .Earth ? 1 : 0)
                }
                .overlay {
                    ItemView(item: .Mars)
                        .opacity(selection == .Mars ? 1 : 0)
                }
                .overlay {
                    ItemView(item: .Jupiter)
                        .opacity(selection == .Jupiter ? 1 : 0)
                }
                .overlay {
                    ItemView(item: .Saturn)
                        .opacity(selection == .Saturn ? 1 : 0)
                }
                .offset(z: modelDepth)

            Picker("Satellite", selection: $selection) {
                ForEach(Item.allCases) { item in
                    Text(item.name)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 900)
        }
    }
}

/// A 3D model loaded from the app's asset bundle.
private struct ItemView: View {
    var item: Item
    
    @State private var degrees = 0.0

    var body: some View {
        VStack {
            Model3D(named: item.name, bundle: realityKitContentBundle) { model in
                model.resizable()
                    .scaledToFit()
                    .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0)
                    )
                    .frame(depth: modelDepth)
                    .offset(z: -modelDepth / 2)
            } placeholder: {
                ProgressView()
                    .offset(z: -modelDepth * 0.75)
            }
            
            Button("Rotate") {
                withAnimation {
                    self.degrees += 90
                }
            }
        }
    }
}

#Preview {
    Planet()
        
}
