//
//  FavoriteModel.swift
//  Dulce
//
//  Created by admin on 06/01/2021.
//  Copyright © 2021 colman. All rights reserved.
//

import Foundation

class FavoriteModel {
    let modelFirebase = ModelFirebase()
    let modelSql = ModelSql2.instance
    
    static let instance = FavoriteModel()
    
    private init(){ }
    
    func addfavorite(favorite:Favorite, callback: @escaping ()->Void){
        modelFirebase.ref.child("favorites").child(favorite.Id).setValue(favorite.toJson())
    }
    
    func getUserFavorites(userId:String, callback: @escaping ([Favorite])->Void){
        //get the local last update date
        var lud = modelSql.getLastUpdateDate(name: "FAVORITES");
        let oldLud = lud
        
        //get the cloud updates since the local update date
        modelFirebase.getFavoritesFB(since:lud) { (data) in
            //insert update to the local db
            for favorite in data!{
                self.modelSql.addFavorite(favorite: favorite)
                
                if favorite.lastUpdate != nil && favorite.lastUpdate! > lud {
                    lud = favorite.lastUpdate!
                }
            }
            
            if (lud > oldLud){
                //update the students local last update date
                self.modelSql.setLastUpdate(name: "FAVORITES", lastUpdated: lud)
            }
            
            // get the complete student list
            let finalData = self.modelSql.getUserFavorites(userId: userId)
            callback(data!);
        }
    }
}
