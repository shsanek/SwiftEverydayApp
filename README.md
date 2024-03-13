# SwiftEverydayApp

This library provides quick functionality to run a Mac application from `spm`. This has limited functionality and is used to quickly create demo applications

## FastStart

Create an object of class App and pass your content to it

NSView:
```
App {
    MyNSView()
}.run()
```

or SwiftUI:
```
App {
    MySwiftUIView()
}.run()
```

You can also pass the size and name parameters

```
App(name: "MyApp", size: .constant(.init(width: 300, height: 300)) {
    MySwiftUIView()
}.run()
```

or specify full screen mode

```
App(name: "MyApp", size: .fullScreen) {
    MySwiftUIView()
}.run()
```
