//
//  VideoController.swift
//  翠堤湾
//
//  Created by 凌甜 on 2021/4/6.
//

import UIKit
import AVFoundation
open class VideoController: UIViewController {
    public var backStr: String?
    public var playStr: String? {
        didSet {
            player?.play()
          //  addWarningLabel()
        }
    }
    
  open var back: Bool = false {
        didSet {
            if back == true {
                let btn = UIButton.init(frame: CGRect.init(x: 2469 * kW, y: 136 * kH, width: 58 * kW, height: 51 * kH))
                view.addSubview(btn)
                btn.setImage(UIImage.imageWithName(str: "back.png", with: "Other"), for: .normal)
                btn.addTarget(self, action:#selector(backClick) , for: .touchUpInside)
            }
        }
    }
    
    var hidden:Bool = false {
        didSet {
            if hidden == true {
                dismiss(animated: false, completion: nil)
                NotificationCenter.default.post(name: Notification.Name.init(changeRootNotification), object: nil)
            }else {
                if playIndex == -1 {
                    player?.play()
                    playIndex = 0
                }else if playIndex == 0 {
                    player?.pause()
                    playIndex = -1
                }
            }
        }
    }
    var playIndex = 0
   lazy var player: AVPlayer? = {
        guard let playStr = playStr else {
            return nil
        }
        let url = URL.init(fileURLWithPath: String.ATTFileNameWIthStr(str: playStr))
        let player = AVPlayer.init(url: url)
        let playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.frame = view.bounds
        playView.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(self, selector: #selector(playbackFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        return player
    }()
    
    lazy var playView: UIView = {
        let playView = UIView.init(frame: kScreenBound)
        view.addSubview(playView)
        return playView
    }()
    
    var shouldAddGes: Bool = false{
        didSet {
            if shouldAddGes == true {
                let tap = UITapGestureRecognizer.init(target: self, action:#selector(tap(tapGes:)))
                playView.addGestureRecognizer(tap)
                let pan = UIPanGestureRecognizer.init(target: self, action:#selector(pan(panGes:)))
                playView.addGestureRecognizer(pan)
            }
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
     
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension VideoController {
    @objc func playbackFinished() {
        if hidden == true {
            dismiss(animated: false, completion: nil)
            NotificationCenter.default.post(name: Notification.Name.init(changeRootNotification), object: nil)
        }else {
            player?.seek(to: CMTime.init(value: CMTimeValue.init(0.0), timescale: CMTimeScale.init(1)))
            player?.play()
            playIndex = 0
        }
    }
    
    @objc func pan(panGes:UIPanGestureRecognizer) {
        let location = panGes.translation(in: playView)
        let range = player?.currentItem?.loadedTimeRanges.first?.timeRangeValue
        guard let newRange = range else {
            return
        }
        let time = CMTimeAdd(newRange.start, newRange.duration)
        let lastTime = CMTimeGetSeconds(time)
        let scale = CGFloat(kW * 2.0) / CGFloat (lastTime)
        let timeX = location.x * scale
        let timeValue = Float(CMTimeGetSeconds((player?.currentTime())!)) + Float(timeX)
        let value = CMTimeValue.init(timeValue)
        let newTime = CMTime.init(value: value, timescale: CMTimeScale(1.0))
       player?.seek(to: newTime)
    }
    
    @objc func tap(tapGes:UITapGestureRecognizer) {
        if hidden == true {
            dismiss(animated: false, completion: nil)
            NotificationCenter.default.post(name: Notification.Name.init(changeRootNotification), object: nil)
        }else {
            if playIndex == -1 {
                player?.play()
                playIndex = 0
            }else if playIndex == 0 {
                player?.pause()
                playIndex = -1
            }
        }
    }
    
    @objc func backClick() {
        Socket.sharedInstance.broadCast(message: backStr ?? "")
      //  playSoundEffect(name: "effect.mp3", type: " ")
        dismiss(animated: false, completion: nil)
    }
    
    func addWarningLabel() {
        let label = UILabel.init(frame: CGRect.init(x: 60*kW, y: 1950*kH, width: 2609*kW, height: 47*kH))
        label.numberOfLines = 0
        let str = "以上建筑和景观部分仅为示意，具体以交付为准；其中单体外烟道及地库出地面风井等构筑物未建入模型内，模型细部未涉及到位，且以上外墙颜色分隔可能与后期实体交付有差异，具体以实际交付为准。"
        var dic = [NSAttributedString.Key : Any]()
        dic[NSAttributedString.Key.font] = UIFont.init(name: "SourceHanSansCN-Medium", size: 20*kH)
        let paragrphStyle = NSMutableParagraphStyle()
        paragrphStyle.lineSpacing = 10*kH
        dic[NSAttributedString.Key.paragraphStyle] = paragrphStyle
        dic[NSAttributedString.Key.foregroundColor] = kARGB(0.8,256,256,256)
        let string = NSAttributedString.init(string: str, attributes: dic)
        label.attributedText = string
        view.addSubview(label)
    }
   
}


