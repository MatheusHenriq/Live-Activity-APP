//
//  LiveActivityManager.swift
//  Runner
//
//  Created by Matheus Henrique on 03/09/24.
//

import Foundation
import ActivityKit



@available(iOS 16.2, *)
class LiveActivityManager {
    private var liveActivity: Activity<LiveActivityWidgetAttributes>? = nil
       
   
    func startLiveActivity(data: [String: Any]?) {
        let attributes = LiveActivityWidgetAttributes()
        if let info = data {
            let state =  LiveActivityWidgetAttributes.ContentState(
                driverCode: info["driverCode"] as? String ?? "", carModel: info["carModel"] as? String ?? "", minutesToArrive: info["minutesToArrive"] as? Int ?? 0, carArriveProgress: info["carArriveProgress"] as? Int ?? 0
            )
            Task{
                liveActivity = try? Activity<LiveActivityWidgetAttributes>.request(attributes: attributes,  content: .init(state: state, staleDate: nil), pushType: .token)               
            }
        }
    }
    

    func updateLiveActivity(data: [String: Any]?) {
        if let info = data {
        let updatedState = LiveActivityWidgetAttributes.ContentState(
            driverCode: info["driverCode"] as? String ?? "", carModel: info["carModel"] as? String ?? "", minutesToArrive: info["minutesToArrive"] as? Int ?? 0, carArriveProgress: info["carArriveProgress"] as? Int ?? 0
           )

        Task {
          await liveActivity?.update(using: updatedState)
        }
      } 
    }
    
        
    func endLiveActivity() {
        Task {
            await self.liveActivity?.end(dismissalPolicy: .immediate)
        }
    }
}
    

