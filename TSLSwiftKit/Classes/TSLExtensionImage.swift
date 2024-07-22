//
//  TSLExtensionImage.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/3.
//  图片模糊效果

import UIKit
import Accelerate

extension UIImage {
    
    // MARK: 颜色透明度、半径、色彩饱和度
    public func imgWithLightAlpha(_ alpha: CGFloat, radius: CGFloat, colorSaturationFactor: CGFloat) -> UIImage {
        let tintColor = kColorRGBAlpha(180, green: 180, blue: 180, alpha: alpha)
        return self.imgBluredWithRadius(radius, tintColor: tintColor, saturationDeltaFactor: colorSaturationFactor, maskImage: nil)
    }
    
    // MARK: 内部方法,核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度
    func imgBluredWithRadius(_ blurRadius: CGFloat, tintColor: UIColor, saturationDeltaFactor: CGFloat, maskImage: UIImage?) -> UIImage {
    
        let imageRect = CGRect(origin: CGPoint.zero, size: self.size)
        
        var effectImage = self
        
        let hasBlur = blurRadius > CGFloat.leastNormalMagnitude
        
        let hasSaturationChange = abs(saturationDeltaFactor - 1.0) > CGFloat.leastNormalMagnitude
        
        if hasBlur || hasSaturationChange {
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
            
            let effectInContext = UIGraphicsGetCurrentContext()
            effectInContext?.scaleBy(x: 1.0, y: -1.0)
            effectInContext?.translateBy(x: 0, y: -self.size.height)
            effectInContext?.draw(self.cgImage!, in: imageRect)
            
            var effectInBuffer = vImage_Buffer(data: effectInContext?.data, height: vImagePixelCount(effectInContext!.height), width: vImagePixelCount(effectInContext!.width), rowBytes: effectInContext!.bytesPerRow)
            
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
            
            let effectOutContext = UIGraphicsGetCurrentContext()
            
            var effectOutBuffer = vImage_Buffer(data: effectOutContext?.data, height: vImagePixelCount(effectOutContext!.height), width: vImagePixelCount(effectOutContext!.width), rowBytes: effectOutContext!.bytesPerRow)
            
            if hasBlur {
                let inputRadius = blurRadius * UIScreen.main.scale
                
                var radius = floor(inputRadius * 3.0 * sqrt(2 * Double.pi) / 4 + 0.5)
                
                if radius.truncatingRemainder(dividingBy: 2.0) != 1 {
                    radius += 1
                }
                
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, UInt32(radius), UInt32(radius), UnsafePointer(bitPattern: 0), vImage_Flags(kvImageEdgeExtend))
                
                vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil, 0, 0, UInt32(radius), UInt32(radius), UnsafePointer(bitPattern: 0), vImage_Flags(kvImageEdgeExtend))
                
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, UInt32(radius), UInt32(radius), UnsafePointer(bitPattern: 0), vImage_Flags(kvImageEdgeExtend))
            }
            
            if hasSaturationChange {
                let satur = saturationDeltaFactor
                
                let floatingPointSaturationMatrix = [0.0722 + 0.9278 * satur, 0.0722 - 0.0722 * satur, 0.0722 - 0.0722 * satur, 0, 0.7152 - 0.7152 * satur, 0.7152 + 0.2848 * satur, 0.7152 - 0.7152 * satur, 0, 0.2126 - 0.2126 * satur, 0.2126 - 0.2126 * satur, 0.2126 + 0.7873 * satur, 0, 0, 0, 0, 1]
                let divisor: CGFloat = 256
                
                let matrixSize = MemoryLayout.size(ofValue: floatingPointSaturationMatrix) / MemoryLayout.size(ofValue: floatingPointSaturationMatrix[0])
                
                var saturationMatrix = [Int16](repeating: 0, count: matrixSize)
                
                for index in 0..<matrixSize {
                    saturationMatrix[index] = Int16(Float(floatingPointSaturationMatrix[index] * divisor))
                }
                
                if hasBlur {
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                } else {
                    vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, Int32(divisor), nil, nil, vImage_Flags(kvImageNoFlags))
                }
            }
            
            effectImage = UIGraphicsGetImageFromCurrentImageContext()!
                
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        //  开启上下文 用于输出图像
        let outputContext = UIGraphicsGetCurrentContext()
        outputContext?.scaleBy(x: 1.0, y: -1.0)
        outputContext?.translateBy(x: 0, y: -self.size.height)
        
        //  开始画底图
        outputContext?.draw(self.cgImage!, in: imageRect)
        
        //  开始画模糊效果
        if hasBlur {
            outputContext?.saveGState()
            
            if maskImage != nil {
                outputContext?.clip(to: imageRect, mask: (maskImage?.cgImage)!)
            }
            
            outputContext?.draw(effectImage.cgImage!, in: imageRect)
            outputContext?.restoreGState()
        }
        
        // 添加颜色渲染
        outputContext?.saveGState()
        outputContext?.setFillColor(tintColor.cgColor)
        outputContext?.fill(imageRect)
        outputContext?.restoreGState()
        
        // 输出成品,并关闭上下文
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outputImage!
    }

}
