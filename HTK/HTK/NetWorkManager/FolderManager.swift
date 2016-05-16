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

func createDirectoryAt(path : String)
{
    let fileManager = NSFileManager.defaultManager()
    if !fileManager.fileExistsAtPath(path)
    {
        let attributes = [NSFileProtectionKey:NSFileProtectionComplete];
        do
        {
            try fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: attributes)
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
