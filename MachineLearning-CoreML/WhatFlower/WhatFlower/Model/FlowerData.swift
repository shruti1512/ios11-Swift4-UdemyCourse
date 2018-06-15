//
//  FlowerData.swift
//  WhatFlower
//
//  Created by Shruti Sharma on 6/15/18.
//  Copyright © 2018 Shruti Sharma. All rights reserved.
//

import Foundation

struct Flower: Decodable {
    
    private(set) var flowerID: String
    private(set) var title: String
    private(set) var description: String
    private(set) var imageURLString: String
}
