//
//  ExamApp.swift
//  Exam
//
//  Created by Pauline Broängen on 2022-11-07.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct ExamApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var dbConnection = DatabaseConnection()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environmentObject(dbConnection)
                LoginView().environmentObject(dbConnection)
                RegisterView().environmentObject(dbConnection)
            }
        }
    }
}
