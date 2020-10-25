//
//  AppErrors.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/10/25.
//

enum AppErrors: Error {
    
    // MARK: - 用户端错误：表单错误或者权限不清
    case UserNetworkError
    case UserFormError

    // MARK: - 后端服务器错误：服务端爬虫错误
    case ServerError
    case ServerSpiderError
    
    // MARK: - 源站不通
    case LNTUEducationError
    case LNTUQualityError
    case AiPaoError
}
