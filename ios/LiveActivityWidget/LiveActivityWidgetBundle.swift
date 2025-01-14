//
//  LiveActivityWidgetBundle.swift
//  LiveActivityWidget
//
//  Created by Matheus Henrique on 13/01/25.
//

import WidgetKit
import SwiftUI

@main
struct LiveActivityWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveActivityWidget()
        LiveActivityWidgetLiveActivity()
    }
}
