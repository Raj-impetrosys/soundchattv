//
//  CollageLayoutView.swift
//  soundchattv
//
//  Created by RAJKUMAR on 16/06/23.
//

import SwiftUI

//struct CollageLayoutView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
struct CollageLayoutView: View {
    
    @State private var photoPickerIsPresented = false
    @State var pickerResult: [UIImage] = []
    
    var body: some View {
      NavigationView {
        ScrollView {
            if pickerResult.isEmpty {
                
            } else {
                CollageLayoutOne(uiImageOne: pickerResult[0], uiImageTwo: pickerResult[1], uiImageThree: pickerResult[2])
            }
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
//        .navigationBarTitle("Select Photo", displayMode: .inline)
        .navigationBarItems(trailing: selectPhotoButton)
        .sheet(isPresented: $photoPickerIsPresented) {
//          PhotoPicker(pickerResult: $pickerResult,
//                      isPresented: $photoPickerIsPresented)
        }
      }
    }
    
    @ViewBuilder
    private var selectPhotoButton: some View {
      Button(action: {
        photoPickerIsPresented = true
      }, label: {
        Label("Select", systemImage: "photo")
      })
    }
    
}

struct CollageLayoutOne: View {
    
    var uiImageOne: UIImage
    var uiImageTwo: UIImage
    var uiImageThree: UIImage
    
    var body: some View {
        
        Rectangle()
            .fill(Color.gray)
            .aspectRatio(1.0, contentMode: .fit)
            .overlay {
                HStack {
                    Rectangle()
                        .fill(Color.gray)
                        .overlay {
                            Image(uiImage: uiImageOne)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .clipped()
                    VStack {
                        Rectangle()
                            .fill(Color.gray)
                            .overlay {
                                Image(uiImage: uiImageTwo)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                        Rectangle()
                            .fill(Color.gray)
                            .overlay {
                                Image(uiImage: uiImageThree)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                            .clipped()
                    }
                }
                .padding()
            }
    }
}

struct CollageLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        CollageLayoutView()
    }
}
