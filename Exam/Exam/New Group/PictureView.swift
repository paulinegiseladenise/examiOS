//
//  PictureView.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-09.
//

import SwiftUI

struct PictureView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var body: some View {
        VStack {
            Text("I can add whatever I want here.....")
            Text("Pictures?").font(.title)
        }
    }
}




struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView()
    }
}
