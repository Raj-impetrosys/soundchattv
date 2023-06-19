//
//  ToastView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 09/06/23.
//

import SwiftUI

struct ToastView: View {
    @Binding var isPresented: Bool
    var message: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Text(message)
                    .font(.system(size: 20))
                    .padding()
            }
            .background(Color.white)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isPresented = false
            }
        }
    }
}

//
//struct ToastView_Previews: PreviewProvider {
//    static var previews: some View {
//        ToastView()
//    }
//}
