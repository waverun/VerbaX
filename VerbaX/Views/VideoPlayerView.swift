import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill // Set video gravity to aspectFill
        controller.view.backgroundColor = .clear

//        if let playerLayer = controller.view.layer.sublayers?.first as? AVPlayerLayer {
//            playerLayer.setAffineTransform(CGAffineTransform(translationX: 0, y: -50)) // Adjust the y value as needed
//        }

        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Nothing to update
    }
}
