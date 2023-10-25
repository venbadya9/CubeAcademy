import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Variables
    
    var authToken: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Accessing authtoken saved in plist for api calls.
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let plistDict = NSDictionary(contentsOfFile: path) {
            if let authenticationToken = plistDict["AuthToken"] as? String {
                authToken = authenticationToken
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

