//
//  ClassroomModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

import Foundation

struct ClassroomResponse: Codable {
    let code: Int
    let message: String
    let data: [ClassroomResponseData]
}

struct ClassroomResponseData: Codable {
    let address: String
    let num: Int
    let type: String
    let data: [ClassroomDetail]
    
    struct ClassroomDetail: Codable, CustomStringConvertible {
        let a, b, c, d, e: Int
        
        var description: String {
            return "\(a) \(b) \(c) \(d) \(e)"
        }
    }
}

extension ClassroomResponseData: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(address)
        hasher.combine(type)
    }
    
    static func == (lhs: ClassroomResponseData, rhs: ClassroomResponseData) -> Bool {
        if lhs.address == rhs.address && lhs.type == rhs.type {
            return true
        } else {
            return false
        }
    }
}

struct ClassroomForm {
    var week: Int
    var campus: CampusEnum {
        didSet {
            if campus == .hld {
                selectedBuilding = HLDBuildingEnum.yhl.rawValue
            } else if campus == .fxb {
                selectedBuilding = FXBBuildingEnum.bwl.rawValue
            } else {
                selectedBuilding = FXNBuildingEnum.byl.rawValue
            }
        }
    }
    var buildingList: Array<String> {
        if campus == .hld {
            return HLDBuildingEnum.allCases.map { $0.rawValue }
        } else if campus == .fxb {
            return FXBBuildingEnum.allCases.map { $0.rawValue }
        } else {
            return FXNBuildingEnum.allCases.map { $0.rawValue }
        }
    }
    var selectedBuilding: String = HLDBuildingEnum.yhl.rawValue
}

enum CampusEnum: String, CaseIterable, Identifiable {
    case hld = "葫芦岛校区"
    case fxn = "阜新南校"
    case fxb = "阜新北校"
    
    var id: String {
        return self.rawValue
    }
}

enum HLDBuildingEnum: String, CaseIterable, Identifiable {
    case yhl = "耘慧楼"
    case eyl = "尔雅楼"
    case jyl = "静远楼"
    case hldjf = "葫芦岛机房"
    case hldwlsys = "葫芦岛物理实验室"
    
    var id: String {
        return self.rawValue
    }
}

enum FXNBuildingEnum: String, CaseIterable, Identifiable {
    case byl = "博雅楼"
    case xhl = "新华楼"
    case zhl = "中和楼"
    case zyl = "致远楼"
    case zxl = "知行楼"
    case wlsys = "物理实验室"
    
    var id: String {
        return self.rawValue
    }
}

enum FXBBuildingEnum: String, CaseIterable, Identifiable {
    case bwl = "博文楼"
    case zljf = "主楼机房"
    
    var id: String {
        return self.rawValue
    }
}

enum AllBuildingEnum: String, CaseIterable {
    case yhl = "耘慧楼"
    case eyl = "尔雅楼"
    case jyl = "静远楼"
    case hldjf = "葫芦岛机房"
    case hldwlsys = "葫芦岛物理实验室"
    
    case byl = "博雅楼"
    case xhl = "新华楼"
    case zhl = "中和楼"
    case zyl = "致远楼"
    case zxl = "知行楼"
    case wlsys = "物理实验室"
    
    case bwl = "博文楼"
    case zljf = "主楼机房"
    
    var varName: String {
        get { return String(describing: self) }
    }
}
