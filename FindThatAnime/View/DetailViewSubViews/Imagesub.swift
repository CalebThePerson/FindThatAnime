//
//  Imagesub.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 10/11/20.
//

import SwiftUI

struct Imagesub: View {
    var Screensize: CGSize
    var DaImage: UIImage
    
    var body: some View {
        VStack{
            Image(uiImage: DaImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Screensize.width - 100, height: 200)
                .clipped()
        }
        .frame(width: Screensize.width - 100 , height: 200)
        
    }
}

struct Imagesub_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{geo in
            Imagesub(Screensize: geo.size, DaImage: UIImage(imageLiteralResourceName: "Lucoa"))
        }
    }
}

