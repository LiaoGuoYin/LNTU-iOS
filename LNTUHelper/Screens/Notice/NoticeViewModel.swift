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

extension NoticeViewModel {
    convenience init(for: String="") {
        let demoData = """
        {
          "code": 200,
          "message": "Success",
          "data": [
            {
              "title": "关于 2021 届毕业生学历证书照片采集的通知",
              "date": "2020-10-27",
              "content": "关于 2021 届毕业生学历证书照片采集的通知",
              "appendix": [],
              "url": "http://jwzx.lntu.edu.cn/index/../info/1103/1575.htm"
            }
          ]
        }
        """.data(using: .utf8)!
        let noticeList = try! JSONDecoder().decode(NoticeResponse.self, from: demoData).data
        self.init()
        self.noticeList = noticeList
    }
}
