//
//  ContentView.swift
//  ScrollParalex
//
//  Created by David on 12/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            Home()
                .navigationTitle("Parallax scroll")
        }
    }
}

#Preview {
    ContentView()
}
