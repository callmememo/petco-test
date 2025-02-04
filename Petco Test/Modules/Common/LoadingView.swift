//
//  LoadingView.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 04/02/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView("Loading....")
                .padding()
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
