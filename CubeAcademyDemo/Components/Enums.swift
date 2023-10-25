import Foundation

// Enum for HTTP Type
enum HTTPType: String {
    case post = "POST"
    case get = "GET"
}

// Enum for API Type
enum APIType: String {
    case fetch = "Fetch"
    case submit = "Submit"
}

// Enum for Satisfaction Type
enum SatisfactionType: String {
    case veryUnFair = "very_unfair"
    case unfair = "unfair"
    case notSure = "not_sure"
    case fair = "fair"
    case veryFair = "very_fair"
}
