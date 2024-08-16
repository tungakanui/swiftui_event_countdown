import SwiftUI

struct EventsView: View {
    @State private var events: [Event]
    
    init(events: [Event]) {
        _events = State(initialValue: events)
    }
    
    var body: some View {
        NavigationStack {
            List(events, id: \.self) {
                event in
                NavigationLink(value: event){
                    EventRow(event: event)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteEvent(event)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            } 
            .navigationDestination(for: Event.self){
                event in
                EventForm(event: event, onSave: { updatedEvent in
                        if let index = events.firstIndex(where: { $0.id == event.id }) {
                            events[index] = updatedEvent
                        }
                    }
                )
            }
            .navigationTitle("Events")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: EventForm(onSave: { newEvent in
                        events.append(newEvent)
                    })) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteEvent(_ event: Event) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events.remove(at: index)
        }
    }
}

#Preview {
    EventsView(events: [
        Event(title: "Event 1", date: Date(timeIntervalSinceNow: 86400), textColor: .red),
        Event(title: "Event 2", date: Date(timeIntervalSinceNow: 172800), textColor: .blue),
        Event(title: "Event 3", date: Date(timeIntervalSinceNow: 2728000), textColor: .blue),
        Event(title: "Event 4", date: Date(timeIntervalSinceNow: 17280000), textColor: .blue),
        Event(title: "Event 5", date: Date(timeIntervalSinceNow: 172800000), textColor: .blue)
    ])
}
