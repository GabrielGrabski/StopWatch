//
//  AddAlarmView.swift
//  StopWatch
//
//  Created by Gabriel Grabski on 21/09/23.
//

import SwiftUI

struct AddAlarmView: View {
    
    @Binding var alarms: [Alarm]
    @State private var date: Date = Date()
    @State private var label: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Select Time", selection: $date, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                
                GroupBox {
                    TextField("Timer name", text: $label)
                        .textInputAutocapitalization(.never)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        alarms.append(Alarm(time: date, label: label, isOn: true))
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.title3)
                            .foregroundColor(.orange)
                            .bold()
                    }
                }
            }
        }
    }
}

struct AddAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        let alarms = Binding.constant([Alarm]())
        AddAlarmView(alarms: alarms)
    }
}
