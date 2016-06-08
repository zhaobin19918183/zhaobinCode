//
//  DBManager.swift
//  Portal
//
//  Created by Kilin on 16/3/22.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit
import SQLite

enum SQLResult : ErrorType
{
    case QueryFailed
}

struct DBManager
{
    static var sharedManager = DBManager()
    var db : Connection?
    private init () {}

    mutating func connectionDB(path : String) -> Bool
    {
        do
        {
            self.db = try Connection(path)
            return true
        }catch
        {
            return false
        }
    }
    
    mutating func tryConnectDB(path : String) -> Bool
    {
        guard let _ = try? Connection(path,readonly: true) else
        {
            return false
        }
        
        return true
    }
    
    func executeSQLStatementWithTransaction(sqlStatements : [String] , completion : () -> Void )
    {
        do{
            try self.db?.transaction(.Deferred, block: {
                for statement in sqlStatements
                {
                    do{
                        try self.db?.run(statement, [Binding?]())
                    }catch{}
                }
            })
            completion()
        }catch{}
    }
    
    func executeSQLStatement(statement : String , schemaList : NSArray) throws -> [ AnyObject ]
    {
        guard !statement.isEmpty else
        {
            throw SQLResult.QueryFailed
        }
        
        guard !(schemaList.count <= 0) else
        {
            throw SQLResult.QueryFailed
        }
        
        var results : [ AnyObject ] = [ AnyObject ]()
        var element : [ String : String ] = Dictionary()
        
        do{
            for table in try self.db!.prepare(statement)
            {
                element = [ : ]
                for index in 0..<schemaList.count
                {
                    let key = String(schemaList[index])
                    if let value = table[index]
                    {
                        element[key] = String(value)
                    }else
                    {
                        element[key] = ""
                    }
                }
                results.append(element)
            }
            
            return results
        }catch
        {
            throw SQLResult.QueryFailed
        }
    }
    
    func executeBatchSqlStatement(batchStatement : String) throws
    {
        try self.db!.execute(batchStatement)
    }
}