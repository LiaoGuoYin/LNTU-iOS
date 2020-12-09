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
    let data: ClassroomResponseData
}

struct ClassroomResponseData: Codable {
    let week, buildingName: String
    let classroomList: [ClassroomResponseDataRow]
}

struct ClassroomResponseDataRow: Codable {
    let room: String
    let type: String
    let capacity: String
    let scheduleList: [String]
}

extension ClassroomResponseDataRow: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(room)
        hasher.combine(type)
    }

    static func == (lhs: ClassroomResponseDataRow, rhs: ClassroomResponseDataRow) -> Bool {
        if lhs.room == rhs.room && lhs.type == rhs.type {
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
    case fxb = "阜新北校"
    case fxn = "阜新南校"
    
    var id: String {
        return self.rawValue
    }
}

enum HLDBuildingEnum: String, CaseIterable, Identifiable {
    case yhl = "耘慧楼"
    case eyl = "尔雅楼"
    case jyl = "静远楼"
    case hldwlsys = "实验楼"
    
    var id: String {
        return self.rawValue
    }
}

enum FXNBuildingEnum: String, CaseIterable, Identifiable {
    case byl = "博雅楼"
    case xhl = "新华楼"
    case zyl = "致远楼"
    case zxl = "知行楼"
    case zhl = "中和楼"
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
    case hldwlsys = "实验楼"
    
    case byl = "博雅楼"
    case xhl = "新华楼"
    case zyl = "致远楼"
    case zxl = "知行楼"
    case zhl = "中和楼"
    case wlsys = "物理实验室"

    
    case bwl = "博文楼"
    case zljf = "主楼机房"
    
    var varName: String {
        get { return String(describing: self) }
    }
}
