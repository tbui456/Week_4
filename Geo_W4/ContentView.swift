import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "location.circle.fill")
                    .font(.system(size: 65))
                    .foregroundStyle(.blue)
                Text("Location Service")
                    .font(.title2.bold())
                Group {
                    statusRow(title: "Services enabled", value: locationManager.servicesEnabled ? "Yes" : "No")
                    statusRow(title: "Permission", value: permissionText)
                }
                Button("Request Location Permission") {
                    locationManager.requestPermission()
                }
                Button("Refresh Status") {
                    locationManager.refreshStatus()
                }
                .buttonStyle(.bordered)
                .padding()
                .navigationTitle("Smart Location")
                .onAppear {
                    locationManager.refreshStatus()
                }
            }
        }
    }
    private func statusRow(title: String, value: String) -> some View {
        HStack {
            Text(title + ":")
                .font(.body)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }
    private var permissionText: String {
        switch locationManager.authorizationStatus{
        case .notDetermined: return "Not Determined"
        case .restricted: return "Restricted"
        case .denied: return "Denied"
        case .authorizedWhenInUse: return "Authorized When In Use"
        case .authorizedAlways: return "Authorized Always"
        @unknown default: return "Unknown"
        
        }
    }
}
#Preview {
    ContentView()
}
