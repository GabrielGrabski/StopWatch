//
//  TimerView.swift
//  StopWatch
//
//  Created by Gabriel Grabski on 21/09/23.
//

import SwiftUI

struct TimerView: View {
    
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0
    @State private var showPicker: Bool = true
    @State private var remainingTime: TimeInterval = TimeInterval(0)
    @State private var timerRunning: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if showPicker {
                HStack {
                    Picker("Hours", selection: $selectedHours) {
                        ForEach(0..<24) { i in
                            Text("\(i)h")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100)
                    
                    Picker("Minutes", selection: $selectedMinutes) {
                        ForEach(0..<60) { i in
                            Text("\(i)m")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100)
                    
                    Picker("Seconds", selection: $selectedSeconds) {
                        ForEach(0..<60) { i in
                            Text("\(i)s")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100)
                }
                .padding()
                
                HStack {
                    Button {
                        showPicker = true
                        timerRunning = false
                    } label: {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 90, height: 90)
                            .overlay {
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                            }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        remainingTime = TimeInterval((selectedHours * 60 * 60) + (selectedMinutes * 60) + selectedSeconds)
                        showPicker = false
                        timerRunning = true
                    } label: {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 90, height: 90)
                            .overlay {
                                Text("Start")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                            }
                    }
                    .padding()
                }
            } else {
                
                ProgressView(value: calculateProgress())
                
                Text(timeString(time: remainingTime))
                    .font(.largeTitle)
                    .padding()
                    .padding(.bottom, 25)
                
                HStack {
                    Button {
                        showPicker = true
                        timerRunning =  false
                    } label: {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 90, height: 90)
                            .overlay {
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                            }
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button {
                        timerRunning.toggle()
                    } label: {
                        Circle()
                            .foregroundColor(timerRunning ? .green : .red)
                            .frame(width: 90, height: 90)
                            .overlay {
                                Text(timerRunning ? "Pause" : "Resume")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .bold()
                            }
                    }

                }
            }
        }
        .preferredColorScheme(.dark)
        .onReceive(timer) { _ in
            if timerRunning {
                remainingTime -= 1
                if remainingTime == 0 {
                    timerRunning = false
                    showPicker = true
                }
            }
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func calculateProgress() -> Double {
        let progress = 1 - remainingTime / Double(selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds)
        return progress
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
