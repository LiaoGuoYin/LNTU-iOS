//
//  NoticeViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

class NoticeViewModel: ObservableObject {
    
    @Published var isShowBanner = false
    @Published var banner = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var helperMessage: HelperMessageResponseData
    @Published var noticeList: [NoticeResponseData] = []
    
    init() {
        self.helperMessage = MockData.helperMessage
        
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.helperMessage.rawValue) as? Data {
            self.helperMessage = (try? JSONDecoder().decode(HelperMessageResponse.self, from: actualData))?.data ?? MockData.helperMessage
        }
        
        if let actualData = UserDefaults.standard.object(forKey: SettingsKey.noticeData.rawValue) as? Data {
            self.noticeList = (try? JSONDecoder().decode([NoticeResponseData].self, from: actualData)) ?? []
        }
        
        // self.refreshNoticeList()
        self.refreshHelperMessage()
    }
}


extension NoticeViewModel {
    convenience init(noticeList: [NoticeResponseData]) {
        // MARK: - init for testing
        self.init()
        self.noticeList = noticeList
    }
}

extension NoticeViewModel {
    func refreshNoticeList() {
        APIClient.notice { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "拉取通知失败"
                self.banner.content = self.banner.title + "，请稍后再试 " + error.localizedDescription
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    self.banner.title = "拉取通知失败"
                    return
                }
                
                self.banner.type = .Success
                self.banner.title = "拉取通知成功"
                self.noticeList = response.data
                UserDefaults.standard[.noticeData] = try? JSONEncoder().encode(self.noticeList)
            }
        }
    }
    func refreshHelperMessage() {
        APIClient.helperMessage { (result) in
            switch result {
            case .failure(let error):
                self.banner.type = .Error
                self.banner.title = "初始化数据拉取失败"
                self.banner.content = error.localizedDescription
            case .success(let response):
                self.banner.type = .Success
                self.banner.content = response.message
                guard response.code == 200 else {
                    self.banner.type = .Error
                    return
                }
                
                self.banner.title = "初始化数据拉取成功"
                self.helperMessage = response.data
                UserDefaults.standard[.helperMessage] = try? JSONEncoder().encode(self.helperMessage)
            }
        }
    }
}
