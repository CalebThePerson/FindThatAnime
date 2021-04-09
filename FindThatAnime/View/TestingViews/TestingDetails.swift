//
//  TestingDetails.swift
//  FindThatAnime
//
//  Created by Caleb Wheeler on 10/9/20.
//

import SwiftUI

struct TestingDetails: View {
    
    var Name: String
    var Epsiode: Int
    var body: some View {
        Text(Name)
        
        Spacer()
        
        Text("\(Epsiode)")
    }
}

struct TestingDetails_Previews: PreviewProvider {
    static var previews: some View {
        TestingDetails(Name: "CumLord", Epsiode: 7)
    }
}
