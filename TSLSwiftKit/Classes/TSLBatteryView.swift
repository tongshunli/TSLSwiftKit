//
//  TSLBatteryView.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/24.
//

import UIKit

enum TSLBatteryStateColor: Int {
    case normal // 正常状态
    case charging // 充电状态
    case warning // 电量不足
}

public class TSLBatteryView: UIView {

    let batteryWidth = 25.0 // 电池宽度
    
    let batteryLineWidth = 1.0 // 电池线宽
    
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
        self.createSubviews()
        self.batteryLevelChanged()
        self.updateTime()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize() {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        
        NotificationCenter.default.addObserver(forName: UIDevice.batteryLevelDidChangeNotification, object: nil, queue: OperationQueue.main) { [unowned self] _ in
            self.batteryLevelChanged()
        }
        
        NotificationCenter.default.addObserver(forName: UIDevice.batteryStateDidChangeNotification, object: nil, queue: OperationQueue.main) { [unowned self] _ in
            self.batteryStateChanged()
        }
    }
    
    func createSubviews() {
        self.layer.addSublayer(self.batteryLayer1)
        
        self.layer.addSublayer(self.batteryLayer2)
        
        self.addSubview(self.batteryView)
        
        self.addSubview(self.batteryLabel)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [unowned self] _ in
            self.updateTime()
        })
    }
    
    lazy var batteryLayer1: CAShapeLayer = {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 4.0, width: self.batteryWidth, height: 12), cornerRadius: 2.0)
        
        var batteryLayer1 = CAShapeLayer()
        batteryLayer1.lineWidth = self.batteryLineWidth
        batteryLayer1.strokeColor = UIColor.gray.cgColor
        batteryLayer1.fillColor = kClearColor.cgColor
        batteryLayer1.path = path.cgPath
        return batteryLayer1
    }()
    
    lazy var batteryLayer2: CAShapeLayer = {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.batteryWidth + 1.0, y: 8.0))
        path.addLine(to: CGPoint.init(x: self.batteryWidth + 1.0, y: 12.0))
        
        var batteryLayer2 = CAShapeLayer()
        batteryLayer2.lineWidth = 2
        batteryLayer2.strokeColor = UIColor.gray.cgColor
        batteryLayer2.fillColor = kClearColor.cgColor
        batteryLayer2.path = path.cgPath
        return batteryLayer2
    }()
    
    lazy var batteryView: UIView = {
        var batteryView = TSLUIFactory.view()
        batteryView.layer.cornerRadius = 1.0
        batteryView.frame = CGRect(x: 1, y: 4.0 + self.batteryLineWidth, width: 0, height: 12.0 - self.batteryLineWidth * 2)
        return batteryView
    }()
    
    lazy var batteryLabel: UILabel = {
        var batteryLabel = TSLUIFactory.label(kFont(10), textColor: UIColor.gray)
        batteryLabel.frame = CGRect(x: self.batteryWidth + 5.0, y: 4.0, width: 80, height: 12.0)
        return batteryLabel
    }()
    
    // MARK: 电量状态发生变化
    func batteryLevelChanged() {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        
        var batteryLevel = device.batteryLevel * 100
        
        if batteryLevel < 0 {
            batteryLevel = 0
        } else if batteryLevel > 100 {
            batteryLevel = 100
        }
        
        if batteryLevel <= 10 {
            self.changeBatteryState(.warning)
        } else {
            self.changeBatteryState(.normal)
        }
        
        var frame = self.batteryView.frame
        frame.size.width = Double(batteryLevel) * (self.batteryWidth - self.batteryLineWidth * 2) / 100
        self.batteryView.frame = frame
    }
    
    // MARK: 当前时间
    func updateTime() {
        let now = Date()
        
        let calendar = Calendar.current
        
        let dateComponent = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        
        let hour = dateComponent.hour
        
        let minute = dateComponent.minute
        
        if hour ?? 0 < 10 && minute ?? 0 < 10 {
            batteryLabel.text = "0\(hour ?? 0):0\(minute ?? 0)"
        } else if hour ?? 0 < 10 {
            batteryLabel.text = "0\(hour ?? 0):\(minute ?? 0)"
        } else if minute ?? 0 < 10 {
            batteryLabel.text = "\(hour ?? 0):0\(minute ?? 0)"
        } else {
            batteryLabel.text = "\(hour ?? 0):\(minute ?? 0)"
        }
    }
    
    // MARK: 电池状态发生变化
    func batteryStateChanged() {
        switch UIDevice.current.batteryState {
        case .unplugged:
            self.changeBatteryState(.normal)
        case .charging:
            self.changeBatteryState(.charging)
        case .full:
            self.changeBatteryState(.charging)
        default:
            self.changeBatteryState(.normal)
        }
    }
 
    func changeBatteryState(_ batteryState: TSLBatteryStateColor) {
        switch batteryState {
        case .charging:
            self.batteryView.backgroundColor = kColorRGB(75, green: 216, blue: 102)
        case .warning:
            self.batteryView.backgroundColor = kColorRGB(252, green: 62, blue: 46)
        default:
            self.batteryView.backgroundColor = kColorRGB(131, green: 131, blue: 131)
        }
    }
    
    public var batteryTintColor: UIColor? {
        didSet {
            self.batteryLayer1.strokeColor = batteryTintColor?.cgColor
            
            self.batteryLayer2.strokeColor = batteryTintColor?.cgColor
            
            self.batteryLabel.textColor = batteryTintColor
            
            if UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full {
                self.changeBatteryState(.charging)
            }
        }
    }
 
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
