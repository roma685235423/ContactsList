import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    static func interpolate(from: UIColor, to: UIColor, progress: CGFloat) -> UIColor {
           var fromRed: CGFloat = 0
           var fromGreen: CGFloat = 0
           var fromBlue: CGFloat = 0
           var fromAlpha: CGFloat = 0
           
           var toRed: CGFloat = 0
           var toGreen: CGFloat = 0
           var toBlue: CGFloat = 0
           var toAlpha: CGFloat = 0
           
           from.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
           to.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
           
           let red = fromRed + (toRed - fromRed) * progress
           let green = fromGreen + (toGreen - fromGreen) * progress
           let blue = fromBlue + (toBlue - fromBlue) * progress
           let alpha = fromAlpha + (toAlpha - fromAlpha) * progress
           
           return UIColor(red: red, green: green, blue: blue, alpha: alpha)
       }
}
