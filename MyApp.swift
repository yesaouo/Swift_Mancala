import SwiftUI
import AVFoundation

@main
struct MyApp: App {
    @AppStorage("music") var music: Int = 0
    init() {
        AVPlayer.setupBgMusic(n: music)
        AVPlayer.bgQueuePlayer.play()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
