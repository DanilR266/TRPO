import UIKit
import AVFoundation
import AVKit

class VideoPlaybackViewController: UIViewController {

    var videoURL: URL?
    var player: AVPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let videoURL = videoURL else {
            print("Invalid video URL")
            return
        }
        player = AVPlayer(url: videoURL)

        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)

        // Начать воспроизведение видео
        player?.play()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        if let playerItem = note.object as? AVPlayerItem {
            // Сбросить воспроизведение к началу
            playerItem.seek(to: CMTime.zero)
            player?.play()
        }
    }
}
