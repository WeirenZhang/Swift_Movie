//
//  MoyaResultValidatePlugin.swift
//
//  Created by Insect on 2018/10/22.
//  Copyright © 2018 insect_qy. All rights reserved.
//

import Moya

/// Moya.Result 校验插件，处理 Result<Moya.Response, MoyaError> 类型的返回结果
/// 必须实现 TargetType & CustomMoyaResultable 两个 protocol
public final class MoyaResultValidatePlugin: PluginType {
    public func process(_ result: Result<Moya.Response, MoyaError>,
                        target: TargetType) -> Result<Moya.Response, MoyaError> {
        guard
            let target = asMoyaResultValidate(target)
        else {
            return result
        }

        switch result {
        case let .success(response):

            // 服务端返回的数据是否符合成功约定
            if target.isResultSuccess(response: response) {
                return result
            }
            // 返回默认错误
            return .failure(.underlying(ValidateError(response: response), response))
        case .failure:
            return result
        }
    }

    private func asMoyaResultValidate(_ target: TargetType) -> MoyaResultValidateable? {
        if let multiTarget = target as? Moya.MultiTarget { // 如果是 MultiTarget，则取出真实的 TargetType
            return multiTarget.target as? MoyaResultValidateable
        }
        return target as? MoyaResultValidateable
    }
    
    public init() {}
}
