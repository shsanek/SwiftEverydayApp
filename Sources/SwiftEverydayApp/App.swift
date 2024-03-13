#if canImport(AppKit)
import AppKit
import SwiftUI

@available(macOS 10.15, *)
public class App: NSObject, NSApplicationDelegate {
    public enum AppSize {
        case fullScreen
        case constant(CGSize)

        var cgSize: CGSize {
            switch self {
            case .fullScreen:
                return NSScreen.main?.visibleFrame.size ?? .init(width: 480, height: 270)
            case .constant(let size):
                return size
            }
        }

        var isFullScreen: Bool {
            switch self {
            case .fullScreen:
                return true
            case .constant:
                return false
            }
        }
    }
    class WindowDelegate: NSObject, NSWindowDelegate {
        func windowWillClose(_ notification: Notification) {
            NSApplication.shared.terminate(0)
        }
    }

    private let window = NSWindow()
    private let windowDelegate = WindowDelegate()
    private let content: NSView
    private let name: String
    private let size: AppSize

    public init(name: String = "App", size: AppSize = .constant(.init(width: 480, height: 270)), _ content: () -> NSView) {
        self.name = name
        self.content = content()
        self.size = size
        super.init()
        let app = NSApplication.shared
        app.delegate = self
    }

    public init<ViewType: View>(name: String = "App", size: AppSize = .constant(.init(width: 480, height: 270)), _ content: () -> ViewType) {
        self.content = NSHostingView(rootView: content())
        self.name = name
        self.size = size
        super.init()
        let app = NSApplication.shared
        app.delegate = self
    }

    public func run() {
        let app = NSApplication.shared
        app.run()
    }

    public func applicationDidFinishLaunching(_ notification: Notification) {
        let appMenu = NSMenuItem()
        appMenu.submenu = NSMenu()
        appMenu.submenu?.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        let mainMenu = NSMenu(title: name)
        mainMenu.addItem(appMenu)
        NSApplication.shared.mainMenu = mainMenu

        window.setContentSize(size.cgSize)
        window.styleMask = [.closable, .miniaturizable, .resizable, .titled]
        window.delegate = windowDelegate
        window.title = name

        let view = content
        view.frame = CGRect(origin: .zero, size: size.cgSize)
        view.autoresizingMask = [.height, .width]
        window.contentView!.addSubview(view)
        window.center()
        window.makeKeyAndOrderFront(window)

        if (size.isFullScreen) {
            window.collectionBehavior = .fullScreenPrimary
            if let frame = NSScreen.main?.visibleFrame {
                window.setFrame(frame, display: true)
            }
            window.toggleFullScreen(nil)
        }

        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }
}
#endif
