//
//  AddEventView.swift
//  event_countdown
//
//  Created by Tnui on 16/8/24.
//

import SwiftUI

enum EditMode {
    case add, edit
}

struct EventForm: View {
    @Environment(\.dismiss) private var dismiss
    @State private var eventName: String = ""
    @State private var date = Date()
    @State private var textColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var showError = false
    
    let mode: EditMode
    let onSave: (Event) -> Void
    
    init(event: Event? = nil, onSave: @escaping (Event) -> Void) {
        self.onSave = onSave
        if let data = event {
            self.mode = EditMode.edit
            _eventName = State(initialValue: data.title)
            _date = State(initialValue: data.date)
            _textColor = State(initialValue: data.textColor)
        } else {
            self.mode = EditMode.add
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                TextField("Enter event name", text: $eventName)
                    .background(Color.white)
                    .foregroundColor(textColor)
                
                if showError && eventName.isEmpty {
                    Text("Event name cannot be empty")
                        .foregroundColor(.red)
                        .font(.caption)
                       
                }

                Divider()
                
                DatePicker("Date", selection: $date)
                    .background(Color.white)
                
                Divider()
                
                ColorPicker("Text Color", selection: $textColor)
                    .background(Color.white)
            }
            
               
            Spacer()
                
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: saveEvent) {
                    Image(systemName: "checkmark")
                }
            }
        }
        .navigationTitle(mode == .add ? "Add Event" : "Edit \(eventName)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveEvent() {
        if eventName.isEmpty {
            showError = true
        } else {
            let newEvent = Event(title: eventName, date: date, textColor: textColor)
            onSave(newEvent)
            dismiss()
        }
    }
}

#Preview {
    EventForm(onSave: { _ in })
}
