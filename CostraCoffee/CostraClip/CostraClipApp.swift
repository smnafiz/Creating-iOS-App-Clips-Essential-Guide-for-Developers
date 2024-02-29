//
//  CostraClipApp.swift
//  CostraClip
//
//  Created by Nafiz on 1/25/24.
//

import SwiftUI
import CoreLocation
import AppClip

@main
struct CostraClipApp: App {
    @StateObject private var model = CoffeeModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(model)
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb, perform: handleUserActivity)
            .onAppear { requestAuthorizationForNotification(); }
        }
    }
    
    func handleUserActivity(_ userActivity: NSUserActivity) {
        if let webpage = userActivity.webpageURL {
            let coffeeId = webpage.lastPathComponent
            if !coffeeId.isEmpty {
                print("coffee id: \(coffeeId)")
                model.findCoffeeById(id: coffeeId)
            }
        }
        
        guard
            let incomingURL = userActivity.webpageURL,
            let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            return
        }
        
        guard
            let payload = userActivity.appClipActivationPayload,
            let latitudeValue = queryItems.first(where: { $0.name == "latitude" })?.value,
            let longitudeValue = queryItems.first(where: { $0.name == "longitude" })?.value,
            let latitude = Double(latitudeValue),
            let longitude = Double(longitudeValue)
        else {
            return
        }
        
        let c = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let r = CLCircularRegion(center: c, radius: 100, identifier: "coffee_location")
        
        payload.confirmAcquired(in: r) { region, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                // Do something
            }
        }
    }
    
    func requestAuthorizationForNotification() {
      let nc = UNUserNotificationCenter.current()
        nc.getNotificationSettings { setting in
    
        if setting.authorizationStatus == .ephemeral {
            print("permsission")
            return
        }

        nc.requestAuthorization(options: .alert) { result, error  in
              print("Result: \(result)  \(String(describing: error))")
        }
      }
    }
}
