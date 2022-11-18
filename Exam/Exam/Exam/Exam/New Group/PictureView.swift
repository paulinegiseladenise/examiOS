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
            Text("I could have done (well done) VG-krav here")
            Text("Pictures?").font(.title)
        }
    }
}




struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView()
    }
}
