//
//  LiveActivityWidgetLiveActivity.swift
//  LiveActivityWidget
//
//  Created by Matheus Henrique on 13/01/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var driverCode : String
        var carModel : String
        var minutesToArrive: Int
        var carArriveProgress: Int
    }
}

struct LiveActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityWidgetAttributes.self) { context in
            if(context.state.carArriveProgress < 100) {
                CarArravingView(context: context).activityBackgroundTint(Color.black.opacity(0.7))
            }else{
                CarArrivedView(context: context).activityBackgroundTint(Color.black.opacity(0.7))
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    if(context.state.carArriveProgress < 100){
                        Text("Pickup in").foregroundColor(.white).padding(EdgeInsets(top: 4, leading: 12, bottom: 0, trailing: 12))
                    }else{
                        Text("Driver Arrives").foregroundColor(.white).padding(EdgeInsets(top: 4, leading: 12, bottom: 0, trailing: 12))
                    }
                   
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if(context.state.carArriveProgress < 100){
                        Text("\(context.state.minutesToArrive) min").foregroundColor(.white).padding(EdgeInsets(top: 4, leading: 12, bottom: 0, trailing: 12))
                    }else{
                        Text("Enjoy your trip").foregroundColor(.white).padding(EdgeInsets(top: 4, leading: 12, bottom: 0, trailing: 12))
                    }
                   
                }
                DynamicIslandExpandedRegion(.bottom) {
                    if(context.state.carArriveProgress < 100){
                        ProgressBarWithCar(progress: context.state.carArriveProgress).padding(EdgeInsets(top: 0, leading: 42, bottom: 0, trailing: 42))
                    }else{
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                            Circle().fill(Color.blue).frame(width: 52,height: 52)
                            Image("flag").resizable().frame(width: 42,height: 42).scaledToFit().aspectRatio(contentMode: .fit)
                        })
                    }
                  
                }
            } compactLeading: {
                if(context.state.carArriveProgress < 100){Text("Pickup in").foregroundColor(.white)}
                else{Text("Driver Arrives").foregroundColor(.white)}
                
            } compactTrailing: {
                if(context.state.carArriveProgress < 100){ Text("\(context.state.minutesToArrive) min").foregroundColor(.white)}
                else{  ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                    Circle().fill(Color.blue).frame(width: 32,height: 32)
                    Image("flag").resizable().frame(width: 25,height: 25).scaledToFit().aspectRatio(contentMode: .fit)
                })}
            } minimal: {
                Text("minimal").foregroundColor(.white)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveActivityWidgetAttributes {
    fileprivate static var preview: LiveActivityWidgetAttributes {
        LiveActivityWidgetAttributes()
    }
}

extension LiveActivityWidgetAttributes.ContentState {
    fileprivate static var smiley: LiveActivityWidgetAttributes.ContentState {
        LiveActivityWidgetAttributes.ContentState(driverCode: "Matheus", carModel: "Virtus", minutesToArrive: 10, carArriveProgress: 30)
     }
     
     fileprivate static var starEyes: LiveActivityWidgetAttributes.ContentState {
         LiveActivityWidgetAttributes.ContentState(driverCode: "Matheus", carModel: "Virtus", minutesToArrive: 10, carArriveProgress: 30)
     }
}

#Preview("Notification", as: .content, using: LiveActivityWidgetAttributes.preview) {
   LiveActivityWidgetLiveActivity()
} contentStates: {
    LiveActivityWidgetAttributes.ContentState.smiley
    LiveActivityWidgetAttributes.ContentState.starEyes
}

struct CarArravingView : View{
    let context: ActivityViewContext<LiveActivityWidgetAttributes>

    init(context: ActivityViewContext<LiveActivityWidgetAttributes>) {
          self.context = context
    }
    
    var body : some View{
        VStack{
            HStack(alignment:.center, content: {
                VStack(alignment: .leading, content: {
                    Text("Pickup in \(context.state.minutesToArrive) min").semiBold18() .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 2))
                    Text("\(context.state.driverCode) - \(context.state.carModel)").regular16()
                })
                Spacer()
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                    Circle().fill(Color.blue).frame(width: 48,height: 48)
                    Image("driver").resizable().frame(width: 32,height: 32).scaledToFit().aspectRatio(contentMode: .fit)
                })
                   
                
            })
           
                ProgressBarWithCar(progress: context.state.carArriveProgress)
           
            
    }.padding(EdgeInsets(top: 12, leading: 42, bottom: 0, trailing: 42))
    }
}

struct CarArrivedView : View{
    let context: ActivityViewContext<LiveActivityWidgetAttributes>

    init(context: ActivityViewContext<LiveActivityWidgetAttributes>) {
          self.context = context
    }
    
    var body : some View{
        VStack{
            HStack(alignment:.center, content: {
                VStack(alignment: .leading, content: {
                    Text("Your Driver Arrives").semiBold18() .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 2))
                    Text("Have a confort trip").regular16()
                })
                Spacer()
                ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                    Circle().fill(Color.blue).frame(width: 52,height: 52)
                    Image("flag").resizable().frame(width: 42,height: 42).scaledToFit().aspectRatio(contentMode: .fit)
                })
                   
            })
           
            
    }.padding(EdgeInsets(top: 12, leading: 42, bottom: 16, trailing: 42))
    }
}


struct ProgressBarWithCar: View {
   var progress: Int = 0
    @State private var barWidth: CGFloat = 0
    init(progress: Int ) {
        self.progress = progress
    }
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                ProgressView(value: Double(self.progress), total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: .white)).background(Color.gray.opacity(0.4)).frame(height: 28)
                                        .cornerRadius(6)
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear.onAppear {
                                self.barWidth = geometry.size.width
                            }
                        }
                    )

                ZStack {
                    Image("car")
                        .resizable()
                        .frame(width: 32, height: 42)
                        .scaledToFit()
                }
                .offset(x: CGFloat(Double(self.progress) / 100) * barWidth - 32)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
            
           
        }
    }
}

extension Text {
   
    func semiBold18() -> some View {
        self.fontWeight(.semibold).font(.system(size: 20)).foregroundColor(.white)
    }
    
    func regular16() -> some View {
        self.fontWeight(.regular).font(.system(size: 16)).foregroundColor(.gray.opacity(0.8))
    }
}

