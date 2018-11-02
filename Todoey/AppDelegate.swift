//
//  AppDelegate.swift
//  Todoey
//
//  Created by Pinar Unsal on 2018-08-12.
//  Copyright © 2018 S Pinar Unsal. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //Gets call as soon as the app loaded up - very first thing
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm \(error)")
        }
        return true
    }
}

