//
//  UpdateDetail.swift
//  DesingCode1
//
//  Created by Vitor Capretz on 2020-05-19.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import SwiftUI

struct UpdateDetail: View {
    var update: Update
    
    var body: some View {
        ScrollView {
            VStack {
                Image(update.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                
                Text(update.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(update.title)
        }
    }
}

struct UpdateDetail_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetail(update: updateData[0])
    }
}
