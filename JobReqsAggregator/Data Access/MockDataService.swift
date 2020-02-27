//
//  MockDataService.swift
//  JobReqsAggregator
//
//  Created by Alexander Parshakov on 1/25/20.
//  Copyright © 2020 Alexander Parshakov. All rights reserved.
//

import Foundation

struct MockDataService {
    
    static func fetchPosts() -> [Post] {
        let material1 = Material(id: 0, name: "Apple Do's and Dont's", url: "https://developer.apple.com/design/tips/", positions: nil)
        let material2 = Material(id: 1, name: "Apple Guidelines", url: "https://developer.apple.com/design/human-interface-guidelines/", positions: nil)
        let relatedMaterials1 = [material1, material2]
        
        let cSharpDeveloper = Position(id: 0, title: "C# Developer", description: "No description", avgSalary: 90000, openVacancies: 421, skillsRequired: nil, relatedCourses: nil, relatedMaterials: nil)
        let post1 = Post(id: 0, position: cSharpDeveloper, supportNumber: 14, title: "Пять вещей, которые я бы посоветовал начинающим", content: mockPostText, timePosted: "12:41")
        
        let uxDesigner = Position(id: 1, title: "UX-дизайнер", description: "No description", avgSalary: 70000, openVacancies: 41, skillsRequired: nil, relatedCourses: nil, relatedMaterials: relatedMaterials1)
        let post2 = Post(id: 1, position: uxDesigner, supportNumber: 14, title: "Ожидаемые изменения в UX", content: mockPostText, timePosted: "13:34")
        
        let metroDriver = Position(id: 2, title: "Водитель метро", description: "No description", avgSalary: 40000, openVacancies: 9, skillsRequired: nil, relatedCourses: nil, relatedMaterials: nil)
        let post3 = Post(id: 2, position: metroDriver, supportNumber: 14, title: "Что на самом деле важно", content: mockPostText, timePosted: "13:59")
        
        let pilot = Position(id: 3, title: "Пилот самолета", description: "No description", avgSalary: 83500, openVacancies: 4, skillsRequired: nil, relatedCourses: nil, relatedMaterials: nil)
        let post4 = Post(id: 3, position: pilot, supportNumber: 14, title: "Хотите летать? Получите права", content: mockPostText, timePosted: "15:18")
        
        return [post1, post2, post3, post4].sorted(by: {$0.timePosted > $1.timePosted})
        
    }
    
    static let mockPostText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Velit dignissim sodales ut eu sem integer vitae justo eget. Et leo duis ut diam. Consequat nisl vel pretium lectus quam id. Semper feugiat nibh sed pulvinar proin gravida. Habitasse platea dictumst quisque sagittis purus. Id eu nisl nunc mi. Neque volutpat ac tincidunt vitae. In pellentesque massa placerat duis ultricies lacus. Euismod in pellentesque massa placerat. Neque aliquam vestibulum morbi blandit cursus risus. Lorem ipsum dolor sit amet. Morbi blandit cursus risus at. Id volutpat lacus laoreet non. Dictum fusce ut placerat orci nulla. Sagittis orci a scelerisque purus semper. Tristique senectus et netus et malesuada fames ac turpis egestas. \n\nId diam vel quam elementum pulvinar etiam non. Leo vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Felis bibendum ut tristique et egestas quis ipsum. Quisque id diam vel quam elementum pulvinar etiam. Cursus euismod quis viverra nibh cras pulvinar. Fermentum posuere urna nec tincidunt. Senectus et netus et malesuada fames ac. Enim ut tellus elementum sagittis vitae et leo. Sed arcu non odio euismod lacinia at. Mauris sit amet massa vitae tortor condimentum lacinia quis. Sed velit dignissim sodales ut eu sem. Consequat id porta nibh venenatis cras sed felis eget velit. In arcu cursus euismod quis viverra nibh cras pulvinar mattis. \n\nUt tristique et egestas quis ipsum. Tincidunt augue interdum velit euismod in pellentesque. Euismod quis viverra nibh cras pulvinar mattis. Odio tempor orci dapibus ultrices in iaculis nunc sed augue. Odio euismod lacinia at quis risus sed vulputate odio ut. Faucibus interdum posuere lorem ipsum dolor sit amet. Euismod quis viverra nibh cras pulvinar mattis. Malesuada pellentesque elit eget gravida cum sociis natoque. Quis auctor elit sed vulputate mi sit amet mauris. Metus aliquam eleifend mi in. Elit at imperdiet dui accumsan sit amet nulla facilisi. Eget magna fermentum iaculis eu non diam phasellus. Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Sed pulvinar proin gravida hendrerit. Pulvinar pellentesque habitant morbi tristique senectus et netus et. Velit aliquet sagittis id consectetur purus. Iaculis nunc sed augue lacus viverra vitae congue eu. \n\nQuam lacus suspendisse faucibus interdum posuere lorem ipsum. Donec adipiscing tristique risus nec feugiat in fermentum. Tortor consequat id porta nibh venenatis cras sed felis. Sed risus ultricies tristique nulla. Mauris pellentesque pulvinar pellentesque habitant morbi. Mattis molestie a iaculis at erat. Egestas sed tempus urna et pharetra pharetra massa. Tellus id interdum velit laoreet id donec. Est placerat in egestas erat imperdiet sed. Integer eget aliquet nibh praesent tristique magna sit amet purus. Euismod nisi porta lorem mollis aliquam ut porttitor. Pellentesque id nibh tortor id aliquet lectus. Sem fringilla ut morbi tincidunt augue interdum velit euismod. Donec et odio pellentesque diam. Et odio pellentesque diam volutpat commodo sed. Fringilla phasellus faucibus scelerisque eleifend. Ultrices in iaculis nunc sed augue lacus. In vitae turpis massa sed. Lectus magna fringilla urna porttitor rhoncus dolor purus. Venenatis tellus in metus vulputate."
}
