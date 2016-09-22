//
//  PasswordDAO.swift
//  EveryOne
//
//  Created by Zhao.bin on 16/1/12.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import Foundation
import UIKit

func initialDirectories()
{
    createDirectoryAt(kPathCoreData)
}

func createDirectoryAt(_ path : String)
{
    let fileManager = FileManager.default
    if !fileManager.fileExists(atPath: path)
    {
        let attributes = [FileAttributeKey.protectionKey:FileProtectionType.complete];
        do
        {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: attributes)
            print("Create Directory Success - \n\(path)\n")
        }
        catch
        {
            print("Create Directory Failed - \n\(path)\n - \n\(error)\n")
        }
    }
    else
    {
        print("Directory at \n\(path)\nis exist!")
    }
}
