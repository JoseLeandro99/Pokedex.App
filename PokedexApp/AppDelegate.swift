import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        navigationBarAppearanceConfig()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let layout = UICollectionViewFlowLayout()
        let pokedexController = PokedexController(collectionViewLayout: layout)
        let navigationController = UINavigationController(rootViewController: pokedexController)
        
        window?.rootViewController = navigationController
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
