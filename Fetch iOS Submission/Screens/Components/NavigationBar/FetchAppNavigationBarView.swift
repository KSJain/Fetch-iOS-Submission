//
//  FetchAppNavigationBarView.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import SwiftUI

struct FetchAppNavigationBarView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Spacer()
                
                Text("Fetch")
                    .font(.system(size: 29, weight: .bold))
                
                Text("App")
                    .font(.system(size: 28, weight: .ultraLight))
            }
            
            Spacer()
        }
    }
}
