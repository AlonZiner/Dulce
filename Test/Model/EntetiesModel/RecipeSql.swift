////
////  RecipeSql.swift
////  Dulce
////
////  Created by admin on 02/01/2021.
////  Copyright © 2021 colman. All rights reserved.
////
//
//import Foundation
//
//extension Recipe{
//    
//    static func create_table(database: OpaquePointer?){
//        var errormsg: UnsafeMutablePointer<Int8>? = nil
//        let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS STUDENTS (ST_ID TEXT PRIMARY KEY, NAME TEXT, AVATAR TEXT)", nil, nil, &errormsg);
//        if(res != 0){
//            print("error creating table");
//            return
//        }
//    }
//    
//    func add(recipe: Recipe){
//           var sqlite3_stmt: OpaquePointer? = nil
//           if (sqlite3_prepare_v2(ModelSql2().database,"INSERT OR REPLACE INTO RECIPES(ID, TITLE, DIFFICULTY, TIME_TO_MAKE, PUBLISHER, INSTRUCTIONS) VALUES (?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
//               
//               let id = recipe.Id.cString(using: .utf8)
//               let title = recipe.Title.cString(using: .utf8)
//               let difficulty = recipe.Difficulty
//               let timeTomake = recipe.TimeToMake
//               let publisher = recipe.Publisher.cString(using: .utf8)
//               let instructions = recipe.Instructions.cString(using: .utf8)
//               
//               sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
//               sqlite3_bind_text(sqlite3_stmt, 2, title,-1,nil);
//               sqlite3_bind_int(sqlite3_stmt, 3, Int32(difficulty))
//               sqlite3_bind_int(sqlite3_stmt, 4, Int32(timeTomake))
//               sqlite3_bind_text(sqlite3_stmt, 5, publisher,-1,nil);
//               sqlite3_bind_text(sqlite3_stmt, 6, instructions,-1,nil);
//               
//               
//               if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
//                   print("new row added succefully")
//               }
//           }
//       }
//       
//       static func getAllRecipes()->[Recipe]{
//           var sqlite3_stmt: OpaquePointer? = nil
//           var data = [Recipe]()
//           
//        if (sqlite3_prepare_v2(ModelSql2().database,"SELECT * from RECIPES;",-1,&sqlite3_stmt,nil)
//               == SQLITE_OK){
//               while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
//
//                   let id = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
//                   let title = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
//                   let difficulty = Int(sqlite3_column_int(sqlite3_stmt,2))
//                   let timeTomake = Int(sqlite3_column_int(sqlite3_stmt,3))
//                   let publisher = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
//                   let instructions = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
//                   
//                   let recipe = Recipe(Id: id, Title: title, Difficulty: difficulty, TimeToMake: timeTomake, Publisher: publisher, Instructions: instructions)
//                   
//                   data.append(recipe)
//               }
//           }
//           
//           sqlite3_finalize(sqlite3_stmt)
//           return data
//       }
//    
//    static func setLastUpdate(lastUpdated:Int64){
//        return ModelSql2().setLastUpdate(name: "RECIPES", lastUpdated: lastUpdated);
//    }
//    
//    static func getLastUpdateDate()->Int64{
//        return ModelSql2().getLastUpdateDate(name: "RECIPES")
//    }
//    
//    
//}
