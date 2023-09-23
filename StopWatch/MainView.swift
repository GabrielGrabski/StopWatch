//
//  MainView.swift
//  StopWatch
//
//  Created by Gabriel Grabski on 21/09/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            StopWatchView()
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("StopWacth")
                }
            
            AlarmView()
                .tabItem {
                    Image(systemName: "alarm")
                    Text("Alarms")
                }
            
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("Timer")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
