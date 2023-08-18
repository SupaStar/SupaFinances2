//
//  FontStyles
//  SupaFinances2
//
//  Created by Obed Martinez on 18/08/23
//



import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .rounded))
            .fontWeight(.bold)
            .foregroundColor(textColor)
    }
}
struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.footnote, design: .rounded))
            .foregroundColor(textColor)
    }
}
extension View {
    func titleForeground() -> some View {
        self.modifier(TitleStyle())
    }
    func bodyForeground() -> some View {
        self.modifier(BodyStyle())
    }
}
