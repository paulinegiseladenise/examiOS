//
//  DatabaseConnection.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-08.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class DatabaseConnection: ObservableObject {
    
    private var db = Firestore.firestore()
    
    @Published var userLoggedIn = false
    @Published var currentUser: User?
    @Published var userDocument = UserDocument()
    
    var userDocumentListener: ListenerRegistration?
    
    
    //kollar efter förändringar i inlogg och så vidare
    init() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("Vad händer?")
        }
        
        
        
        Auth.auth().addStateDidChangeListener {
            auth, user in
            
            if let user = user {
                //Om user inte är nil så är jag inloggad
                self.userLoggedIn = true
                self.currentUser = user
                self.listenToDb()
            } else {
                self.userLoggedIn = false
                self.currentUser = nil
                self.stopListeningToDb()
                //Om user är nil så har jag loggat ut
            }
        }
    }
    
    
    func stopListeningToDb() {
        if let userDocumentListener = userDocumentListener {
            userDocumentListener.remove()
        }
    }
    
    
    func listenToDb() {
        
        if let currentUser = currentUser {
            
            userDocumentListener = self.db.collection("userData").document(currentUser.uid).addSnapshotListener {
                snapshot, error in
                
                if let error = error {
                    print("Error occurred \(error)")
                    return
                }
                
                guard let snapshot = snapshot else {
                    return
                }
                
                let result = Result {
                    try snapshot.data(as: UserDocument.self)
                }
                
                switch result {
                case .success(let userData):
                    self.userDocument = userData
                    break
                case .failure(let error):
                    print("Something went wrong retrieving data: \(error)")
                    break
                }
            }
        }
    }
    
    
    
    
    
    func SignOut() {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out")
        }
    }
    
    
    
    func LoginUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            authDataResult, error in
            if let error = error {
                print("Something went wrong, \(error.localizedDescription)")
                return
            }
        }
    }
    
    
    
    
    func RegisterUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            authDataResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                
            }
            
            if let authDataResult = authDataResult {
                let newUserDocument = UserDocument(id: authDataResult.user.uid)
                
                do {
                    try self.db.collection("userData").document(authDataResult.user.uid).setData(from: newUserDocument)
                } catch {
                    print("Something went wrong with the registration, \(error.localizedDescription)")
                }
            }
        }
    }
}

