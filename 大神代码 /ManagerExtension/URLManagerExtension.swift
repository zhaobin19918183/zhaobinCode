//
//  URLManagerExtension.swift
//  Portal
//
//  Created by Kilin on 16/3/29.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit

extension URLManager
{
    func getAppSyncURL() -> String
    {
        return "\(self.rootURL)postprocess"
    }
}
