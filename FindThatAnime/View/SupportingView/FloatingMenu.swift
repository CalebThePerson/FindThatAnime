//
//  FloatingMenu.swift
//  AnimeFinder
//
//  Created by Caleb Wheeler on 7/27/20.
//  Copyright © 2020 Caleb Wheeler. All rights reserved.
//

import SwiftUI

struct FloatingMenu: View {
    
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    
    
    @State var ShowView = false
    
    @State private var ShowingImagePicker = false
    @State private var InputImage: UIImage?
    
    let TraceAPI: TraceMoeAPI
    
    
    var body: some View {
        VStack {
            Spacer()
            if showMenuItem1 {
                MenuItem(icon: "gear")
            }
            if showMenuItem2 {
                MenuItem(icon: "book")
            }
            if showMenuItem3 {
                Button(action: { self.ShowingImagePicker.toggle()

                }) {
                    MenuItem(icon: "tv")
                }.sheet(isPresented: $ShowingImagePicker, onDismiss: {self.TraceAPI.CirclePresenting=false; LoadImage(); self.showMenuItem1=false;self.showMenuItem2=false;self.showMenuItem3=false }) {
                    ImagePicker(image: self.$InputImage)
                }
            }
            Button(action: {
                self.showMenu()
            }) {
                Image(systemName: "ellipsis.circle.fill")
                    .resizable()
                    .frame(width: 55, height: 55)
                    .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }
        }
    }
    
    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
    }
    
    func LoadImage(){
        guard let InputImage = InputImage else {return}
        
        print("yeth")
        print(convertImageToBase64(InputImage))
        
    }
    
        func convertImageToBase64(_ image: UIImage) {
            let imageData:NSData = image.jpegData(compressionQuality: 0.4)! as NSData
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            print("Damn")
            TraceAPI.API(ImageString: strBase64)
    }
}


struct FloatingMenu_Previews: PreviewProvider {
    static var previews: some View {
        FloatingMenu(TraceAPI: TraceMoeAPI())
    }
}

struct MenuItem: View {
    
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(red: 153/255, green: 102/255, blue: 255/255))
                .frame(width: 40, height: 40)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
        .transition(.move(edge: .trailing))
    }
}
