import SwiftUI

struct AddressView: View {
    @Binding var order: Order // We're receiving it from elsewhere, bindings create two-way bindings to work with @Observable class
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink("Check Out") { // Goes one view deeper with all pointing to the same object of data
                    CheckoutView(order: order)
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            order.name = UserDefaults.standard.string(forKey: "name") ?? ""
            order.streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
            order.city = UserDefaults.standard.string(forKey: "city") ?? ""
            order.zip = UserDefaults.standard.string(forKey: "zip") ?? ""
        }
    }
}

#Preview {
    AddressView(order: .constant(Order()))
}
