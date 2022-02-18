//
//  SubscriptionViewModel.swift
//  Messangel
//
//  Created by Saad on 1/30/22.
//

import Foundation

struct SubscriptionPlan: Codable {
    var id: Int
    var name, stripePlan, price, storageLimitInMB: String
    var referral: Bool

    enum CodingKeys: String, CodingKey {
        case id, name
        case stripePlan = "stripe_plan"
        case price
        case storageLimitInMB = "storage_limit_in_mb"
        case referral
    }
}

struct Card: Codable {
    var number, expMonth, expYear, cvc: Int
    var currency: String

    enum CodingKeys: String, CodingKey {
        case number
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case cvc, currency
    }
}

struct Subscription: Codable {
    var id: Int?
    var userID, planID: Int
    var status, startDate, endDate, consumptionInMB: String?
    var card: Card?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case planID = "plan_id"
        case status
        case startDate = "start_date"
        case endDate = "end_date"
        case consumptionInMB = "consumption_in_mb"
        case card
    }
}

class SubscriptionViewModel: ObservableObject {
    @Published var checkingSubscription = false
    @Published var gotSubscription = false
    @Published var subscriptions = [Subscription] ()
    @Published var subscription = Subscription(userID: 0, planID: 1, card: Card(number: 0,expMonth: 1,expYear: 2022, cvc: 33, currency: "eur"))
    @Published var plans = [SubscriptionPlan]()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func checkSubscription() {
        self.checkingSubscription.toggle()
        self.subscription.userID = getUserId()
        self.getSubscriptions { success in
            DispatchQueue.main.async {
                self.checkingSubscription.toggle()
                self.gotSubscription = true
                if success {
                    print("\(self.subscriptions.filter( {$0.status == "1"} ).count > 0 ? "User has subscription" : "No Subscriptions available!")")
                }
            }
        }
    }
    
    func subscribe(completion: @escaping (Bool) -> Void) {
        APIService.shared.post(model: subscription, response: subscription, endpoint: "users/plans/subscribe") { result in
            switch result {
            case .success(let subscription):
                DispatchQueue.main.async {
                    self.subscription = subscription
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.error_description)
                    self.apiError = error
                    completion(false)
                }
            }
        }
    }
    
    func unsubscribe() async {
        var request = URLRequest(url: URL(string: "https://messangel.caansoft.com/api/v1/users/subscriptions/\(getUserId())/cancel")!)
        request.setValue("Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        do {
            let (data, response) = try await URLSession.shared.upload(for: request, from: Data())
            if let httpResponse = response as? HTTPURLResponse {
                print("Unsubscribe Status code: \(httpResponse.statusCode)")
            }
            print(String(data: data, encoding: .utf8) ?? "")
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(Networking.APIResponse.self, from: data)
        } catch (let error) {
            print("Unsubscribe error: " + error.localizedDescription)
        }
    }
    
    func getPlans() {
        APIService.shared.getJSON(model: plans, urlString: "users/plans") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.plans = items
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSubscriptions(completion: @escaping (Bool) -> Void) {
        APIService.shared.getJSON(model: subscriptions, urlString: "users/subscriptions/\(getUserId())") { result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self.subscriptions = items
                    completion(true)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}



