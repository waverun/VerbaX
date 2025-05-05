import SwiftUI
import UIKit

struct LaunchImageView: UIViewControllerRepresentable {
    let imageName: String

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = UIScreen.main.bounds
        viewController.view.addSubview(imageView)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Nothing to update
    }
}
