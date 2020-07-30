//
//  CourseStore.swift
//  DesingCode1
//
//  Created by Vitor Capretz on 2020-07-19.
//  Copyright © 2020 Vitor Capretz. All rights reserved.
//

import Foundation
import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "06tihs55uqyh", accessToken: "T5sp-9495D9Az8Bjdl3x9DFwPXjzj-rpa2dBLQU5Rdg")

func getArray(id: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: id)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }
        case .failure(let error):
            print(error)
        }
    }
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    init() {
        let colors = [#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
        
        getArray(id: "course") { items in
            items.forEach { (item) in
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["title"] as! String,
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "https://dl.dropboxusercontent.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!,
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: colors.randomElement()!,
                    show: false
                ))
            }
        }
    }
}
