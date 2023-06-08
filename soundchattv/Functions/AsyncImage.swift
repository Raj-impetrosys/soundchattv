//
//  AsyncImage.swift
//  soundchattv
//
//  Created by RAJKUMAR on 15/05/23.
//

import Foundation
import SwiftUI

struct NetworkImage: View {
    var urlString: String
    var body: some View {
        AsyncImage(
            url: URL(string: urlString),
            content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }, placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            })
    }
}


//func AsyncImage(url: String) -> AsyncImage{
//    return AsyncImage(url: URL(string: url)) { image in
//        image.resizable()
//    } placeholder: {
//        ProgressView()
//    }
//    .frame(width: 50, height: 50)
//}
