//
//  HMResource.swift
//  Homelet
//
//  Created by heshuhua on 2018/2/8.
//  Copyright © 2018年 heshuhua. All rights reserved.
//

import Foundation

class HResource {
    
var name: String
var type: String
var location: String
var phone: String
var description: String
var image: String


init(name: String, type: String, location: String, phone: String, description: String, image: String) {
    self.name = name
    self.type = type
    self.location = location
    self.phone = phone
    self.description = description
    self.image = image

}

convenience init() {
    self.init(name: "", type: "", location: "", phone: "", description: "", image: "")
    }
}
