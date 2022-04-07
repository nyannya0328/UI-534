//
//  ContentView.swift
//  UI-534
//
//  Created by nyannyan0328 on 2022/04/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
