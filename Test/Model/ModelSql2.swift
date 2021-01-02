//
//  ModelSql2.swift
//  Dulce
//
//  Created by admin on 02/01/2021.
//  Copyright © 2021 colman. All rights reserved.
//

import Foundation

class ModelSql2{
    var database: OpaquePointer? = nil
    
    func connect() {
        let dbFileName = "database2.db"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName)
            if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                print("Failed to open db file: \(path.absoluteString)")
                return
            }
        }
        create()
    }

    func create(){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        //let res = sqlite3_exec(database, "DROP TABLE IF EXISTS RECIPES;", nil, nil, &errormsg);
        var res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS RECIPES (ID TEXT PRIMARY KEY, TITLE TEXT, DIFFICULTY INTEGER, TIME_TO_MAKE INTEGER, PUBLISHER TEXT, INSTRUCTIONS TEXT)", nil, nil, &errormsg);

        if(res != 0){
            print("error creating table");
            return
        }
        
        res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS LAST_UPADATE_DATE (NAME TEXT PRIMARY KEY, DATE DOUBLE)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
        
    }
    
    func setLastUpdate(name:String, lastUpdated:Int64){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO LAST_UPADATE_DATE( NAME, DATE) VALUES (?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){

            sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);
            sqlite3_bind_int64(sqlite3_stmt, 2, lastUpdated);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    func getLastUpdateDate(name:String)->Int64{
        var date:Int64 = 0;
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"SELECT * from LAST_UPADATE_DATE where NAME like ?;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);

            if(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                date = Int64(sqlite3_column_int64(sqlite3_stmt,1))
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return date
    }

    
    
    
    // TODO: move to receipe sql
    func add(recipe: Recipe){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO RECIPES(ID, TITLE, DIFFICULTY, TIME_TO_MAKE, PUBLISHER, INSTRUCTIONS) VALUES (?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            
            let id = recipe.Id.cString(using: .utf8)
            let title = recipe.Title.cString(using: .utf8)
            let difficulty = recipe.Difficulty
            let timeTomake = recipe.TimeToMake
            let publisher = recipe.Publisher.cString(using: .utf8)
            let instructions = recipe.Instructions.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, title,-1,nil);
            sqlite3_bind_int(sqlite3_stmt, 3, Int32(difficulty))
            sqlite3_bind_int(sqlite3_stmt, 4, Int32(timeTomake))
            sqlite3_bind_text(sqlite3_stmt, 5, publisher,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, instructions,-1,nil);
            
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
    }
    
    func getAllRecipes()->[Recipe]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Recipe]()
        
        if (sqlite3_prepare_v2(database,"SELECT * from RECIPES;",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){

                let id = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let title = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let difficulty = Int(sqlite3_column_int(sqlite3_stmt,2))
                let timeTomake = Int(sqlite3_column_int(sqlite3_stmt,3))
                let publisher = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                let instructions = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                
                let recipe = Recipe(Id: id, Title: title, Difficulty: difficulty, TimeToMake: timeTomake, Publisher: publisher, Instructions: instructions)
                
                data.append(recipe)
            }
        }
        
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
}