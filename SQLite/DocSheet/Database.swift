//
//  Database.swift
//  Memo
//
//  Created by Ruj on 10/6/2560 BE.
//  Copyright © 2560 Ruj. All rights reserved.
//

import Foundation

class Memo{
    var topic:String = ""
    var content:String = ""
}

class Database {
    
    private var databasePathString:String! = nil
    private var database:OpaquePointer? = nil

    private static var sharedInstance:Database! = nil
    
    private init(){}
    
    static private func createDB() -> Bool{
        
        let db = Database()
    
        var isSuccess:Bool = true;
        
        let fm = FileManager.default
        
        //Get Documents url
        do {
            let docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            // Creat folder
            let myFolderUrl = docsurl.appendingPathComponent("Database", isDirectory: true)
            try fm.createDirectory(at: myFolderUrl, withIntermediateDirectories: true, attributes: nil)
            // Create path to database file
            let myDbFileUrl = myFolderUrl.appendingPathComponent("memo.db")
            db.databasePathString = myDbFileUrl.path
            
            if(!fm.fileExists(atPath: db.databasePathString)){
                // Db File not exists.  Lets make one
                if(sqlite3_open(db.databasePathString, &db.database) == SQLITE_OK){
                    var errMSG:UnsafeMutablePointer<Int8>? = nil
                    
                    let text =
                    "CREATE TABLE \"memo\" (\"ID\" INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL , \"TOPIC\" TEXT, \"CONTENT\" TEXT)"
                    let sql_stmt = text.cString(using: .utf8);
                    if(sqlite3_exec(db.database, sql_stmt!, nil, nil, &errMSG)
                        != SQLITE_OK){
                        isSuccess = false
                        NSLog("Failed to create memo table")
                    }
                    
                    sqlite3_close(db.database);
                    
                    // Store shared when successful
                    sharedInstance = db;
                }else{
                    
                    isSuccess = false
                    NSLog("Failed to open/create database");
                }
            }else{
                sharedInstance = db;
            }
                
        }catch{
            return false
            
        }
        return isSuccess
    }
    
    static func getSharedInstance() -> Database{
        if (sharedInstance == nil) {
            createDB();
        }
        return sharedInstance;
    }
    
    // Create record and return the record number
    func addNote(topic:String, content:String) -> Int{
        var recordNumber:Int = -1;
        var statement:OpaquePointer? = nil;
        
        if (sqlite3_open(self.databasePathString, &self.database) == SQLITE_OK){
            var errMsg:UnsafeMutablePointer<Int8>? = nil
            
            
            let insertSQL =
                "INSERT INTO memo (TOPIC, CONTENT) VALUES (\"" + topic + "\",\"" + content + "\")"
            var sql_stmt = insertSQL.cString(using: .utf8)
            
            if (sqlite3_exec(self.database, sql_stmt!, nil, nil, &errMsg)
                != SQLITE_OK){
                NSLog("Failed to insert into memo table ");
            }else{
                // Get the latest record number
                let lookupSQL = "SELECT MAX(ID) FROM memo"
                sql_stmt = lookupSQL.cString(using: .utf8)
                
                sqlite3_prepare_v2(self.database, sql_stmt!, -1, &statement, nil);
                if (sqlite3_step(statement) == SQLITE_ROW)
                {
                    recordNumber = Int(sqlite3_column_int(statement, 0));
                }
                
                sqlite3_finalize(statement);
                sqlite3_close(database);
            }
        }
        return recordNumber;
    }
    
    func countRecords() -> Int{
        var recordNumber:Int = -1;
        var statement:OpaquePointer? = nil;
        
        if (sqlite3_open(self.databasePathString, &self.database) == SQLITE_OK)
        {
            // Get the latest record number
            let lookupSQL = "SELECT count(Record) FROM RecordSet"
            let sql_stmt = lookupSQL.cString(using: .utf8)
            
            sqlite3_prepare_v2(self.database, sql_stmt!,-1, &statement, nil)
            if (sqlite3_step(statement) == SQLITE_ROW){
                recordNumber = Int(sqlite3_column_int(statement, 0));
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
            
        }
        return recordNumber;
    }
    
    func getNote(recordID:Int) -> Memo{
        let result:Memo = Memo();
        var statement:OpaquePointer? = nil;
        
        if (sqlite3_open(self.databasePathString, &self.database) == SQLITE_OK){
            // Get the latest record number
            let lookupSQL = "SELECT TOPIC, CONTENT FROM  memo WHERE ID = \(recordID)"
            
            let sql_stmt = lookupSQL.cString(using: .utf8)
            
            sqlite3_prepare_v2(self.database, sql_stmt!,-1, &statement, nil)
            if (sqlite3_step(statement) == SQLITE_ROW){
                result.topic = String(cString: sqlite3_column_text(statement, 0))
                result.content = String(cString:sqlite3_column_text(statement, 1))
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(database);
        }
        return result;
    }
}
