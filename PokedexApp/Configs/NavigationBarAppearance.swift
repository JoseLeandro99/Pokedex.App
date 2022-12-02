import UIKit

func navigationBarAppearanceConfig() {
    if #available(iOS 15, *) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .mainPink()
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
