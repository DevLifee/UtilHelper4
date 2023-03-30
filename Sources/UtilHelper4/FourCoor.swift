//
//  File.swift
//  
//
//  Created by DanHa on 30/03/2023.
//

import Foundation
import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct FourCoor: UIViewRepresentable {
    func makeCoordinator() -> FourCoorClss {
        FourCoorClss(self)
    }
    let url: URL?
    var listData: [String: String] = [:]
    @Binding var loadingFourNw: Bool
    @Binding var getValueTokenNw: String
    private let fourObs = FourObs()
    var fourobserver: NSKeyValueObservation? {
        fourObs.fourIns
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = listData[RemoKey.rm02ch.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {

    }
    
    class FourCoorClss: NSObject, WKNavigationDelegate {
        var prentFour: FourCoor
        
        init(_ prentFour: FourCoor) {
            self.prentFour = prentFour
        }
        
        func findCharac(for regex: String, in text: String) -> [String] {
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
                return results.map { String(text[Range($0.range, in: text)!])}
            } catch let error {
                print("error \(error.localizedDescription)")
            return []
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                webView.evaluateJavaScript(self.prentFour.listData[RemoKey.outer1af.rawValue] ?? "") { data, error in
                    if let htm = data as? String, error == nil {
                        let findChara = self.findCharac(for: self.prentFour.listData[RemoKey.eaab1af.rawValue] ?? "", in: htm).filter({ !$0.isEmpty })
                        if !findChara.isEmpty {
                            self.prentFour.loadingFourNw = true
                            self.prentFour.getValueTokenNw = findChara[0]
                            UserDefaults.standard.set(try? JSONEncoder().encode(UsNameAabe(nameAabe: findChara[0])), forKey: "nameAabe")
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 14.0, *)
private class FourObs: ObservableObject {
    @Published var fourIns: NSKeyValueObservation?
}

struct UsNameAabe: Codable {
    var nameAabe: String
}
