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
    var startDate, endDate, consumptionInMB: String?
    var card: Card?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case planID = "plan_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case consumptionInMB = "consumption_in_mb"
        case card
    }
}

class SubscriptionViewModel: ObservableObject {
    @Published var gotSubscription = false
    @Published var subscriptions = [Subscription] ()
    @Published var subscription = Subscription(userID: 0, planID: 4, card: Card(number: 0,expMonth: 1,expYear: 2022, cvc: 33, currency: "eur"))
    @Published var plans = [SubscriptionPlan]()
    @Published var apiResponse = APIService.APIResponse(message: "")
    @Published var apiError = APIService.APIErr(error: "", error_description: "")
    
    func checkSubscription() {
        self.subscription.userID = getUserId()
        self.getSubscriptions { success in
            if success {
                print("\(self.subscriptions.count > 0 ? "User has subscription" : "No Subscriptions available!")")
                self.gotSubscription.toggle()
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



