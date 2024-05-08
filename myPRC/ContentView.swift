import SwiftUI
import MapKit

struct TopBannerView: View {
    var body: some View {
        Image("prcgp")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 60) // Adjust the height as needed
            .background(Color.white) // Set a white background
            //.cornerRadius(0) // Remove any corner radius
            //.padding(0) // Remove any padding
    }
}

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Text("Grace Over Judgement")
                .font(.system(size: 33, weight: .bold)) // Adjust font size and weight as needed
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.black)
            
            // Add any additional content you want to display on the splash screen
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .padding(.top, -80) // Adjust top padding to increase height
    }
}

// MapView is a UIViewRepresentable to wrap the MapKit map view
struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Set up the map view here
        let location = CLLocationCoordinate2D(latitude: 32.736583, longitude: -97.007874)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "2305 Oak Ln # 101-4B"
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}

struct ContentView: View {
    @State private var facebookHandle = ""
    @State private var instagramHandle = ""
    let destinationLocation = CLLocationCoordinate2D(latitude: 32.736583, longitude: -97.007874)
    @State private var showMainContent = false
    
    var body: some View {
        ZStack(alignment: .top) {
            TopBannerView()
        }
        VStack {
            // Main content
            if showMainContent {
                mainContentView()
            } else {
                SplashScreenView()
                    .onAppear {
                        // Show main content after 2 seconds (adjust duration as needed)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showMainContent = true
                        }
                    }
            }
            // Privacy Policy Link
            Link("Privacy Policy", destination: URL(string: "https://yourwebsite.com/privacy")!)
                .foregroundColor(.gray) // Set the color to your preference
                .padding(.bottom, 20) // Add bottom padding
        }
    }
    
    @ViewBuilder
    private func mainContentView() -> some View {
        TabView {
            // Home tab
            NavigationView {
                ScrollView {
                    VStack {
                        Spacer() // Add space between the image and the text
                        Image("first")
                            .resizable()
                            .aspectRatio(contentMode: .fill) // Fill the available space
                            .frame(maxWidth: .infinity) // Stretch to fill horizontally
                            .frame(height: 360) // Maintain height
                            .padding(.vertical) // Add vertical padding around the image
                            .padding()
                        Button(action: {
                            // Functionality for making an appointment
                            if let url = URL(string: "https://prcgp.com/contact") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                           // Spacer() // Add spacer to push content downward
                            Button(action: {
                                // Functionality for initiating a text message
                                let phoneNumber = "4695632624"
                                let message = "Hello, I would like to schedule an appointment."
                                if let url = URL(string: "sms:\(phoneNumber)&body=\(message)") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Text("Text.> ")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .black))
                                    //.padding()
                            }
                         
                        }
                        
                        // Help button functionality changed to navigate to resource section
                        NavigationLink(destination: ResourceActivity()) {
                            ZStack {
                                Color.black
                                    .opacity(0.3)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                VStack {
                                    Image("help")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 120)
                                        .clipped()
                                    Text("Learn about our services.")
                                        .foregroundColor(.white)
                                        .font(.custom("Avenir", size: 18))
                                        .padding(.leading)
                                }
                            }
                            .cornerRadius(10)
                            .padding()
                        }
                        Link(destination: URL(string: "https://prcgp.com/additional_information/")!) {
                            
                            ZStack {
                                Color.black
                                    .opacity(0.3)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                VStack {
                                    Image("additional")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 120)
                                        .clipped()
                                    Text("Additional Information")
                                        .foregroundColor(.white)
                                        .font(.custom("Avenir", size: 18))
                                        .padding(.leading)
                                }
                            }
                            .cornerRadius(10)
                            .padding()
                        }
                        Link(destination: URL(string: "https://prcgp.com/contact")!) {
                            ZStack {
                                Color.white
                                    .opacity(0.8)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                VStack {
                                    Image("ready")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 75)
                                    .padding()
                                }
                            }
                            .padding()
                        }
                        
                        Spacer() // Add spacer to push content downward
                        
                        // Mission Statement
                        ZStack {
                            // Use a lighter shade of the primary color
                            Color(red: 1, green: 0.76, blue: 0.6)
                                .edgesIgnoringSafeArea(.horizontal)
                                .frame(height: 250)
                            Text("OUR MISSION:\nEmpowering women to make positive pregnancy decisions through options, resources, and education, while showing the love of Christ.")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .regular))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .frame(maxWidth: .infinity) // Stretch across left and right
                        
                        Text("Plan your trip")
                            .foregroundColor(.white)
                            .font(.custom("Avenir", size: 18))
                            .padding(.leading)
                        // Move MapView here, at the bottom of the VStack
                        MapView()
                            .frame(height: 200)
                            .edgesIgnoringSafeArea(.bottom)
                        
                        // Button for providing directions
                        Button(action: {
                            // Functionality for providing directions
                            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation))
                            mapItem.name = "Destination"
                            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
                        }) {
                            Text("Get Directions")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        HStack {
                            // Facebook Icon Button
                            Button(action: {
                                // Open Facebook webpage
                                if let url = URL(string: "https://www.facebook.com/pregnancycentergp") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Image("facebook_icon")
                                    .resizable()
                                    .frame(width: 45, height: 40)
                            }
                            .buttonStyle(PlainButtonStyle()) // Apply a button style
                            // Instagram Icon Button
                            Button(action: {
                                // Open Instagram webpage
                                if let url = URL(string: "https://www.instagram.com/pregnancycentergp/") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Image("instagram_icon")
                                    .resizable()
                                    .frame(width: 45, height: 40)
                            }
                            .buttonStyle(PlainButtonStyle()) // Apply a button style
                        }
                        .padding(.bottom) // Add top padding
                    }
                }
                .background(Image("prc").resizable())
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            // Explore tab
            NavigationView {
                ResourceActivity()
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarItems(trailing:
                        NavigationLink(destination: ResourceActivity()) {
                            EmptyView()
                        }
                    )
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Explore")
            }
            
            // Profile tab
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}
struct ProfileView: View {
    @State private var showSettings = false
    @State private var showReminderSheet = false
    @State private var reminderText = ""
    @State private var reminders: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                // Gray background on top
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.gray,
                        Color.white
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .opacity(0.4) // Adjust opacity here
                .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Button(action: {
                            showSettings.toggle()
                        }) {
                            Text("Settings")
                        }
                        .padding()
                        
                        Button(action: {
                            showReminderSheet.toggle()
                        }) {
                            Text("Add Reminder")
                        }
                        .padding()
                        .sheet(isPresented: $showReminderSheet) {
                            ReminderEntryView(showSheet: $showReminderSheet, reminderText: $reminderText, reminders: $reminders)
                        }
                    }
                    
                    VStack {
                        Text("View trimester checklist\n on geisinger.org")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 14)) // Adjust the font size here
                                      Image(systemName: "arrow.up.right.circle.fill")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                if let url = URL(string: "https://www.geisinger.org/patient-care/conditions-treatments-specialty/trimester-to-do-checklist") {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                    List {
                        ForEach(reminders, id: \.self) { reminder in
                            Text(reminder)
                        }
                        .onDelete(perform: deleteReminder) // Enable swipe to delete
                    }
                }
                .navigationBarTitle("Profile")
                .navigationBarItems(trailing:
                    Button(action: {
                        saveAndRelaunch()
                    }) {
                        Text("Save Reminders")
                    }.padding()
                )
            }
        }
        .onAppear {
            loadReminders()
        }
        .onDisappear {
            saveReminders()
        }
    }
    
    private func saveReminders() {
        UserDefaults.standard.set(reminders, forKey: "Reminders")
    }
    
    private func loadReminders() {
        if let savedReminders = UserDefaults.standard.stringArray(forKey: "Reminders") {
            reminders = savedReminders
        }
    }
    
    private func deleteReminder(at offsets: IndexSet) {
        reminders.remove(atOffsets: offsets)
    }
    
    private func saveAndRelaunch() {
        saveReminders()
    }
}



struct ReminderEntryView: View {
    @Binding var showSheet: Bool
    @Binding var reminderText: String
    @Binding var reminders: [String]
    
    var body: some View {
        VStack {
            TextField("Enter reminder", text: $reminderText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Add") {
                if !reminderText.isEmpty {
                    reminders.append(reminderText)
                    reminderText = ""
                    showSheet.toggle()
                }
            }
            .padding()
        }
        .padding()
    }
}

struct SettingsView: View {
    @State private var darkModeEnabled = false
    
    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle("Dark Mode", isOn: $darkModeEnabled)
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
