//
//  ImageCell.swift
//  AnimeFinderUI
//
//  Created by Caleb Wheeler on 9/17/20.
//

import SwiftUI

struct ImageCell: View {
    
    var ScreenSize: CGSize {
        didSet{
            print(ScreenSize)
        }
    }
    var TheImage:UIImage
    
    var body: some View {
        
        VStack {
            Image(uiImage: TheImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ScreenSize.width, height: 140)
                .clipped()
        }
        .frame(width: ScreenSize.width, height: 140)

        
    }
}

struct ImageCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            ImageCell(ScreenSize: geometry.size, TheImage: UIImage(imageLiteralResourceName: "Lucoa"))
        }
    }
}
