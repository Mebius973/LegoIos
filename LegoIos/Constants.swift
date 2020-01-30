//
//  Constants.swift
//  LegoIos
//
//  Created by Mebius on 27/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation

class Constants {

    static var ApiBaseURL: String {
        if CommandLine.arguments.contains("-runlocal") {
            return "http://localhost:9999/api/v3/lego/"
        } else {
            return "https://rebrickable.com/api/v3/lego/"
        }
    }
    static let ColorsEndPoint = "colors/"
    static let ElementsEndPoint = "elements/"
    static let MocsEndPoint = "mocs/"
    static let PartCategoriesEndPoint = "part_categories/"
    static let PartsEndPoint = "parts/"
    static let SetsEndPoint = "sets/"
    static let SetsDefaultParams = "ordering=-year%2C-set_num"
    static let ThemesEndPoint = "themes/"
    static let PoliciesURL = "https://sites.google.com/view/brick-browser/policies"
}
