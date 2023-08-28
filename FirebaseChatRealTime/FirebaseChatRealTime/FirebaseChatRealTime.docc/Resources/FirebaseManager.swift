//
//  FirebaseManager.swift
//  
//
//  Created by Emizen on 28/08/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore
import FirebaseStorage
import FirebaseMessaging
import FirebaseSessions
import Firebase
import FirebaseFirestore


class FirebaseManager{
    
    
    /// Create User On Firebase for login pourpos
     func createAccount(email ID : String, password : String, complition: @escaping(User) ->(),){
        Auth.auth().createUser(withEmail: userID, password: password, completion: { authResult, error in
            // Handle signup completion or error
            if error == nil{
                let user = authResult?.user as? User
                complition(user)
            }else{
                print("Fail to Create User! \(error?.localizedDescription ?? "")")
                complition(nil)
            }
        })
        
    }
    
    
    //MARK: - Login User
    func loginUserFirBase(userID : String!,password : String, complition : @escaping ((_ authResult : AuthDataResult?) -> Void)){
        
        Auth.auth().signIn(withEmail: userID, password: password, completion: {authResult , error in
            if error == nil {
                let user = authResult
                complition(user)
            }else{
                complition(nil)
            }
        })
    }
    
    
    //MARK: - UpDate UserDetails On Firebase
    /// Set User Information on Firebase Realtime database
    /// UserData = Type [String:Any ] in this Formate Can Pass UserAll Detasils
    /// UserID = in This Pass That ID you having Receive when login or Create Account
    func updateUserFirebase(userData: [String : Any] ,userID : String){
        databaseRef = Database.database().reference()
        databaseRef.child("users").child((userID)).updateChildValues(userData){ err,fd in
            
            if err != nil{
                // Handle the error
                print("Failed to save custom data: \(err?.localizedDescription)")
            } else {
                // Custom data saved successfully
                print("Custom data saved successfully\(fd.description())")
                
            }
        }
    }
    
}

