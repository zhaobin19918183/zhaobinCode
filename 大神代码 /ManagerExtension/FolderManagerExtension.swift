//
//  FolderManagerExtension.swift
//  Portal
//
//  Created by Kilin on 16/3/29.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit

extension FolderManager
{
    static func createSSTFoloders()
    {
        self.createFolderWith(PATH_FOLDER_COREDATA)
        self.createFolderWith(PATH_FOLDER_APP)
        self.createFolderWith(PATH_FOLDER_TEMP)
        self.createFolderWith(PATH_FOLDER_DB)
        self.createFolderWith(PATH_FOLDER_XML)
    }
}
