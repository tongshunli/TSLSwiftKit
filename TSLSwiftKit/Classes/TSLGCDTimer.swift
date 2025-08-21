//
//  DVGCDTimer.swift
//  MyEngineeringCollection
//
//  Created by 佟顺利 on 2025/7/2.
//

import UIKit
import Dispatch

enum TSLGCDTimerState: Int {
    case stoped
    case running
    case pausing
}

class TSLGCDTimer: NSObject {
    /// 定时器完成回调
    var timerFinishedBlock: () -> Void = { }
    /// 定时器开始回调
    var timerStartBlock: () -> Void = { }
    /// 定时器运行回调
    var timerRunningBlock: (_ runTimes: Int, _ currentTime: CGFloat) -> Void = { _, _ in }
    /// 定时器终止回调
    var timerTerminateBlock: () -> Void = {}
    /// 定时器恢复回调
    var timerResumeBlock: () -> Void = {}
    /// 定时器暂停回调
    var timerSuspendBlock: () -> Void = {}
    /// 定时器状态
    var timerState: TSLGCDTimerState = .stoped
    
    var immediatelyCallBack: Bool = true
    
    var interval: Double = 1.0
    
    var timer: DispatchSourceTimer?
    
    /// 定时器开启
    func startTimer() {
        if self.timer != nil && self.timerState == .pausing {
            self.resumeTimer()
        }
        self.stopTimer()
        self.createTimer()
    }
    
    var timeDuration: Double? {
        didSet {
            self.startTimer()
        }
    }
    
    /// 定时器停止
    func stopTimer() {
        guard let timer = self.timer else { return }
        if self.timerState == .running {
            timer.cancel()
            self.timer = nil
            self.timerState = .stoped
            self.timerTerminateBlock()
        }
    }
    
    /// 定时器恢复
    func resumeTimer() {
        guard let timer = self.timer else { return }
        if self.timerState == .pausing {
            timer.resume()
            self.timerState = .running
            self.timerResumeBlock()
        }
    }
    
    /// 定时器暂停
    func suspendTimer() {
        guard let timer = self.timer else { return }
        if self.timerState == .running {
            timer.suspend()
            self.timerState = .pausing
            self.timerSuspendBlock()
        }
    }
    
    // MARK: 定时器任务完成
    func finishTimer() {
        guard let timer = self.timer else { return }
        if self.timerState == .running {
            timer.cancel()
            self.timer = nil
            self.timerState = .stoped
            self.timerFinishedBlock()
        }
    }
    
    /// 开启定时器
    func createTimer() {
        var kImmediatelyCallBack = self.immediatelyCallBack
        
        guard var kTimeDuration = self.timeDuration ?? 0 <= 0 ? CGFloat.infinity : self.timeDuration else { return }
                
        // 计时器时间不正确
        if kTimeDuration <= 0 {
            self.timerFinishedBlock()
            return
        }
        
        if self.interval == 0 {
            self.interval = 1
        }
        
        var runTimes = 0
        
        let queue = DispatchQueue.global()
        self.timer = DispatchSource.makeTimerSource(queue: queue)
        self.timer?.schedule(deadline: .now() + self.interval, repeating: .seconds(1))
        self.timer?.setEventHandler { [unowned self] in
            runTimes += 1
            
            self.timerState = .running
            
            if kTimeDuration <= 0 {
                self.finishTimer()
            } else {
                kTimeDuration -= self.interval
                if kImmediatelyCallBack {
                    DispatchQueue.main.async {
                        self.timerRunningBlock(runTimes, kTimeDuration != CGFloat.infinity ? kTimeDuration : 0)
                    }
                }
                kImmediatelyCallBack = true
            }
        }
        self.timer?.resume()
        
        self.timerStartBlock()
    }
}
