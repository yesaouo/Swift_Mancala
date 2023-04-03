import AVFoundation

extension AVPlayer {
    static var bgQueuePlayer = AVQueuePlayer()
    static var bgPlayerLooper: AVPlayerLooper!
    static func setupBgMusic(n: Int) {
        guard let url = Bundle.main.url(forResource: songs[n], withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
    static let arrowBtnPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "zapsplat_multimedia_button_click_fast_wooden_organic_005_78839", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    static let sysBtnPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "zapsplat_multimedia_button_click_bright_001_92098", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    static let crossBtnPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "multimedia_button_click_019", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    static let bigBtnPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "multimedia_button_click_017", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    static let picStnPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "zapsplat_multimedia_button_click_bright_002_92099", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    static let winPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "cartoon_success_fanfair", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    static let losePlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "zapsplat_cartoon_musical_orchestral_pizzicato_riff_fail_lose_short_92168", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    static let earnPointPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "zapsplat_multimedia_game_sound_big_bright_metallic_chime_win_bonus_78301", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
    
    func playFromStart() {
        seek(to: .zero)
        play()
    }
}
