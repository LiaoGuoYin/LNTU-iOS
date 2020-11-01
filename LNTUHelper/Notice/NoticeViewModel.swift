//
//  NoticeViewModel.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/29.
//

import Foundation

class NoticeViewModel: ObservableObject {
    
    @Published var isShowBanner: Bool = false
    @Published var banner: BannerModifier.Data = BannerModifier.Data(content: "") {
        willSet {
            self.isShowBanner = true
        }
    }
    
    @Published var noticeList: [NoticeResponseData]
    
    init(user: User) {
        self.noticeList = []
        self.refreshNoticeList()
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
}

extension NoticeViewModel {
    convenience init() {
        let demoData = """
        {
          "code": 200,
          "message": "Success",
          "data": [
            {
              "title": "关于 2020 年辽宁省本科大学生 “中软国际 -- 卓越杯” AI 挑战赛报名的通知",
              "date": "2020-10-28",
              "content": "关于 2020 年第一届辽宁省普通高等学校本科大学生 “中软国际 -- 卓越杯” AI 挑战赛报名的通知",
              "appendix": [
                {
                  "url": "关于 2020 年辽宁省本科大学生 “中软国际 -- 卓越杯” AI 挑战赛报名的通知.zip",
                  "name": "http://jwzx.lntu.edu.cn//system/_content/download.jsp?urltype=news.DownloadAttachUrl&owner=1522094051&wbfileid=3857349"
                }
              ],
              "url": "http://jwzx.lntu.edu.cn/index/../info/1103/1576.htm"
            },
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
        let user = User(username: "1710022", password: "*")
        let noticeList = try! JSONDecoder().decode(NoticeResponse.self, from: demoData).data
        self.init(user: user)
        self.noticeList = noticeList
    }
}
