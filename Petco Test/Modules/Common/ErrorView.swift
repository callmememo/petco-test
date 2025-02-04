//
//  ErrorView.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 04/02/25.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(errorMessage)
                    .foregroundColor(.primary)
                    .padding()
                Button("Retry") {
                    retryAction()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ErrorView(errorMessage: "Some error") {
        print("retry action")
    }
}
