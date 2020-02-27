//
//  File.swift
//  LegoIos
//
//  Created by Mebius on 04/12/2019.
//  Copyright © 2019 Mebius. All rights reserved.
//

import Foundation
import CoreData

@objc(Set)
public class Set: NSManagedObject, Codable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Set> {
        return NSFetchRequest<Set>(entityName: "Set")
    }

    @NSManaged var lastModifiedDt: String?
    @NSManaged var name: String?
    @NSManaged var rawNumParts: Int32
    var numParts: Int {
        get { return Int(rawNumParts) }
        set { rawNumParts = Int32(newValue) }
    }
    @NSManaged var setImgUrl: String?
    @NSManaged var setNum: String?
    @NSManaged var setUrl: String?
    @NSManaged var rawThemeId: Int32
    var themeId: Int {
        get { return Int(rawThemeId) }
        set { rawThemeId = Int32(newValue) }
    }
    @NSManaged var rawYear: Int32
    var year: Int {
        get { return Int(rawYear) }
        set { rawYear = Int32(newValue) }
    }

    required convenience public init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[CodingUserInfoKey.context!] as? NSManagedObjectContext
            else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Set", in: context)
            else { fatalError() }

        self.init(entity: entity, insertInto: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        lastModifiedDt = try? container.decode(String.self, forKey: .lastModifiedDt)
        name = try? container.decode(String.self, forKey: .name)
        numParts = try container.decode(Int.self, forKey: .numParts)
        setImgUrl = try? container.decode(String.self, forKey: .setImgUrl)
        setNum = try? container.decode(String.self, forKey: .setNum)
        setUrl = try? container.decode(String.self, forKey: .setUrl)
        themeId = try container.decode(Int.self, forKey: .themeId)
        year = try container.decode(Int.self, forKey: .year)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lastModifiedDt, forKey: .lastModifiedDt)
        try container.encode(name, forKey: .name)
        try container.encode(numParts, forKey: .numParts)
        try container.encode(setImgUrl, forKey: .setImgUrl)
        try container.encode(setNum, forKey: .setNum)
        try container.encode(setUrl, forKey: .setUrl)
        try container.encode(themeId, forKey: .themeId)
        try container.encode(year, forKey: .year)
    }

    enum CodingKeys: String, CodingKey {
        case name, year
        case lastModifiedDt = "last_modified_dt"
        case numParts = "num_parts"
        case setImgUrl = "set_img_url"
        case setNum = "set_num"
        case setUrl = "set_url"
        case themeId = "theme_id"
    }
}
