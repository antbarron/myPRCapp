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
            .cornerRadius(0) // Remove any corner radius
            .padding(0) // Remove any padding
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
              VStack {
                  // Top banner
                  TopBannerView()
                   

                  // Main content
                  if showMainContent {
                      mainContentView()
                          .padding() // Bring main content down by 20%
                  } else {
                      SplashScreenView()
                          .onAppear {
                              // Show main content after 2 seconds (adjust duration as needed)
                              DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                  showMainContent = true
                              }
                          }
                  }
              }
          }
             
    
    @ViewBuilder
    private func mainContentView() -> some View {
        TabView {
            // Home tab
            NavigationView {
                ScrollView {
                    VStack {
                        
                       // Spacer() // Add space between the image and the text

                        Button(action: {
                            // Functionality for initiating a text message
                            let phoneNumber = "4695632624"
                            let message = "Hello, I would like to schedule an appointment."
                            
                            if let url = URL(string: "sms:\(phoneNumber)&body=\(message)") {
                                UIApplication.shared.open(url)
                            }
                        }) {            

                            Text("Text. 469.563.2624")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .black))
                                .padding()
                        }
                       // Spacer() // Add spacer to push content downward

                        Image("first")
                            .resizable()
                            .aspectRatio(contentMode: .fill) // Fill the available space
                            .frame(maxWidth: .infinity) // Stretch to fill horizontally
                            .frame(height: 360) // Maintain height
                            .padding(.vertical) // Add vertical padding around the image
                        Button(action: {
                            // Functionality for making an appointment
                            if let url = URL(string: "https://prcgp.com/contact") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Spacer() // Add spacer to push content downward
                            //Spacer() // Add spacer to push content downward

                            Text("Make an Appointment")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                        .padding()
                        
                        // Help button functionality changed to navigate to resource section
                        NavigationLink(destination: ResourceActivity()) {
                            ZStack {
                                // Background Color
                                Color.black
                                    .opacity(-4.8) // Adjust opacity as needed
                                
                                // Help Image
                                Image("help")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill) // Fill the available space
                                    .frame(maxWidth: .infinity) // Stretch to fill horizontally
                                    .frame(height: 120) // Maintain height
                                    .clipped() // Clip overflowing content
                                
                                // Learn about our services Text
                                Text("Learn about our services.")
                                    .foregroundColor(.white)
                                    .font(.custom("Avenir", size: 18)) // Change to your preferred font and adjust size as needed
                                    .padding(.leading)
                            }
                            .cornerRadius(10) // Adjust corner radius as needed
                            .padding()
                        }
                        
                        // Mission Statement
                        Text("OUR MISSION:\n Empowering women to make positive pregnancy decisions through options, resources, and education, while showing the love of Christ.")
                            .foregroundColor(.white)
                            .font(.custom("Snell Roundhand", size: 24)) // Adjust font size as needed
                            .multilineTextAlignment(.center) // Center the text
                            .padding()
                        
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
                                .padding()
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
                        .padding(.top) // Add top padding
                    }
                }
                .background(Image("prc").resizable())
                .navigationBarTitle("")
               .navigationBarHidden(true) // Hide navigation bar
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            
            // Explore tab
            ScrollView {
                VStack {
                    // Content of the Explore tab
                    Text("Explore")
                }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Explore")
            }
            
            // Profile tab
            ScrollView {
                VStack {
                    // Content of the Profile tab
                    Text("Profile")
                }
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
    }
}
#Preview {
    ContentView()
}
