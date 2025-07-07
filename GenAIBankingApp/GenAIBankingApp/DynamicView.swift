//
//  DynamicView.swift
//  GenAIBankingApp
//
//  Created by Kogilapriadarsini Nathan on 23/06/25.
//

import SwiftUI
import CoreML

// MARK: - Model
struct UIComponent: Decodable, Identifiable {
    var id: UUID { UUID() } // Computed property, not decoded
    let type: String
    let value: String?
    let label: String?
    let action: String?
    let data: [Double]?
}

// MARK: - View
struct DynamicBankingUI: View {
    @State private var components: [UIComponent] = []
    @State private var loading = false
    
    var body: some View {
        NavigationView {
            if loading {
                ProgressView("Generating UI...")
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(components) { component in
                            switch component.type {
                            case "text":
                                Text(component.value ?? "")
                                    .font(.title2)
                                    .bold()

                            case "button":
                                Button(action: {
                                    handleAction(component.action)
                                }) {
                                    Text(component.label ?? "Button")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                }

                            case "chart":
                                LineChartPlaceholder(data: component.data ?? [])

                            default:
                                EmptyView()
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Smart Dashboard")
            }
        }
        .onAppear(perform: loadUI)
    }

    func handleAction(_ action: String?) {
        // Perform banking actions like navigation or API calls
        print("Action triggered: \(action ?? "none")")
    }

    func loadUI() {
        loading = true

        // Simulate result from Foundation Model (replace with real CoreML call)
        let fakeJSON = """
        [
            {"type": "text", "value": "Hello Kogila!"},
            {"type": "text", "value": "Your current balance is ₹1,20,000"},
            {"type": "button", "label": "Transfer Money", "action": "transfer"},
            {"type": "button", "label": "View Statement", "action": "statement"},
            {"type": "chart", "data": [120000, 118000, 117000, 119500, 120000]}
        ]
        """

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if let data = fakeJSON.data(using: .utf8) {
                do {
                    components = try JSONDecoder().decode([UIComponent].self, from: data)
                } catch {
                    print("Decoding error: \(error)")
                }
            }
            loading = false
            print("loading done = \(loading)")
        }
    }
}

// MARK: - Placeholder for Line Chart
struct LineChartPlaceholder: View {
    let data: [Double]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Balance Trend")
                .font(.headline)
            HStack {
                ForEach(data.indices, id: \.self) { i in
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: CGFloat(data[i] / (data.max() ?? 1)) * 100 / 120000)
                    }
                }
            }
            .frame(height: 120)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

#Preview {
    DynamicBankingUI()
}
