import SwiftUI

/// A protocol that represents any custom Markdown content.
/// You may use this to include custom content within your markdown content builder.
///
/// ```swift
/// struct MarkdownButton: CustomMarkdownContent {
///   var id: String {
///     title
///   }
///   let title: String
///   let action: () -> Void
///
///   var body: some View {
///     Button(title, action: action)
///   }
/// ```
///
/// And then use it like you would other elements in `Markdown`
///
/// ```swift
/// var body: some View {
///   Markdown {
///     MarkdownButton(title: "Click here", action: didTap)
///   }
/// }
/// ```
public protocol CustomMarkdownContent: MarkdownContentProtocol, Identifiable, View where ID == String {
    // Does nothing
}

extension CustomMarkdownContent {
    public var _markdownContent: MarkdownContent {
        .init(block: .custom(.init(content: self)))
    }
}

struct CustomBlockNode: Hashable, View {
    private let content: any CustomMarkdownContent

    static func == (lhs: CustomBlockNode, rhs: CustomBlockNode) -> Bool {
        lhs.content.id == rhs.content.id
    }

    init(content: any CustomMarkdownContent) {
        self.content = content
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(content.id)
    }

    var body: some View {
        AnyView(content)
    }
}
