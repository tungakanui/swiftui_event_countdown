import SwiftUI

struct EventRow: View {
    let event: Event
    @State private var timeRemaining: String = ""
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(event.title)
                .foregroundColor(event.textColor)
                .font(.system(size: 24))
                .fontWeight(.bold)
            
            Text(timeRemaining)
                .foregroundColor(.secondary)
        }
        .padding()
        .onAppear(perform: updateTimeRemaining)
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }
    
    private func updateTimeRemaining() {
        let now = Date()
        let timeInterval = event.date.timeIntervalSince(now)
        
        if timeInterval > 0 {
            timeRemaining = timeString(from: timeInterval)
        } else {
            timeRemaining = "Event has passed"
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        let years = timeInterval / (12 * 30 * 24 * 60 * 60)
        let months = timeInterval / (30 * 24 * 60 * 60)
        
        if years > 1 {
            let yearCount = Int(years)
            return "in \(yearCount) years"
        } else if months >= 2 {
            let monthCount = Int(months)
            return "in \(monthCount) months"
        } else if months >= 1 {
            return "next month"
        } else if timeInterval >= 3600 { // More than 1 hour
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day, .hour]
            formatter.unitsStyle = .full
            formatter.zeroFormattingBehavior = .dropAll
            return formatter.string(from: timeInterval) ?? "N/A"
        } else {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.day, .hour, .minute, .second]
            formatter.unitsStyle = .full
            formatter.zeroFormattingBehavior = .dropAll
            return formatter.string(from: timeInterval) ?? "N/A"
        }
    }
}

#Preview {
    EventRow(event: Event(title: "Event in 2 months", date: Date(timeIntervalSinceNow: 60 * 60 * 24 * 60), textColor: .red))
}
