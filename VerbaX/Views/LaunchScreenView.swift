import SwiftUI
import AVKit

struct LaunchScreenView: View {
//    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @State private var player: AVPlayer?
    @State private var isVideoLoaded = false
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {

//            GradientView()
            
            LaunchImageView(imageName: "LaunchScreenImage")
                .edgesIgnoringSafeArea(.all)
                .opacity(opacity)

            switch true {
                case isVideoLoaded, player != nil:
                    VideoPlayerView(player: player!)
                        .opacity(opacity)
                        .edgesIgnoringSafeArea(.all)
                        .alignmentGuide(.leading) { d in d[.leading] } // Align to leading edge
                        .onAppear {
                            player?.isMuted = true // Mute the audio
                            player?.play()
                            setupEndNotification()
                        }
                default:
                    Color.orange.edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            loadVideo()
        }
//        .opacity(launchScreenState.state == .finished ? 0 : 1)
//        .animation(.none, value: launchScreenState.state) // Remove any implicit animations
    }

    private func loadVideo() {
        if let videoAsset = NSDataAsset(name: "LessonBlazerLaunch") {
            let tempDirectory = FileManager.default.temporaryDirectory
            let videoURL = tempDirectory.appendingPathComponent("LessonBlazerLaunch.mov")

            do {
                try videoAsset.data.write(to: videoURL)
                player = AVPlayer(url: videoURL)
                isVideoLoaded = true
                print("Video loaded successfully")
                loadVideoDuration()
            } catch {
                print("Error writing video to temporary directory: \(error)")
            }
            return
        }
//        else {
        print("Video asset not found")
//        }
    }

    private func loadVideoDuration() {
        guard let player = player else { return }
        let asset = player.currentItem?.asset

        Task {
            do {
                let duration = try await asset?.load(.duration)
                if let duration = duration {
                    let seconds = CMTimeGetSeconds(duration)
                    print("Video duration: \(seconds) seconds")
                    withAnimation(.linear(duration: seconds)) {
                        opacity = 0.0
                    }
                }
            } catch {
                print("Failed to load video duration: \(error)")
            }
        }
    }

    private func setupEndNotification() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [self] _ in
            self.player?.pause()
            self.player?.seek(to: .zero)
//            self.launchScreenState.state = .finished
        }
    }
}
