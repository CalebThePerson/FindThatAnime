//
//  TestingCell.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 9/24/20.
//

import SwiftUI

struct TestingCell: View {
    
    var ScreenSize: CGSize
    var TheImageName:String
    
    var body: some View {
        
        Image("\(TheImageName)")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: ScreenSize.width - 14, height: 140)
            .clipped()
        
    }

}

struct TestingCell_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            TestingCell(ScreenSize: geometry.size, TheImageName: "Lucoa")
        }
    }
}
