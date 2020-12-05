//
//  NoticeViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

class NoticeViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data() {
        didSet {
            isShowBanner = true
        }
    }
    
    @Published var noticeList: [NoticeResponseData] = []
    @Published var helperMessage: HelperMessageResponseData = HelperMessageResponseData()
    
    init() {
        self.refreshNoticeList()
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
                self.banner.content = error.localizedDescription
            case .success(let response):
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "拉取通知成功"
                    self.noticeList = response.data
                } else {
                    self.banner.type = .Error
                    self.banner.title = "拉取通知失败"
                }
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
                self.banner.content = response.message
                if response.code == 200 {
                    self.banner.type = .Success
                    self.banner.title = "初始化数据拉取成功"
                    self.helperMessage = response.data
                } else {
                    self.banner.type = .Error
                    self.banner.title = "初始化数据拉取失败"
                }
            }
        }
    }
}
