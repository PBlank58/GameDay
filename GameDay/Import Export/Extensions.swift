//
//  Extensions.swift
//  HC_Oppostion
//
//  Created by Brett Pullyblank on 4/6/2023.
//

import SwiftUI

extension View{
   
    //MARK: Extracting View's height and width with the assistance of Hosting Controller and ScrollView
    func convertToScrollView<Content: View>(@ViewBuilder content: @escaping ()->Content)->UIScrollView {
        
        let scrollView = UIScrollView()
        
        //MARK: Converting View to UIkit View
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Constraints
        let constraints = [
            
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            // width Anchor
            scrollView.widthAnchor.constraint(equalToConstant: screenBounds().width)
        ]
       
        scrollView.addSubview(hostingController)
        scrollView.addConstraints(constraints)
        scrollView.layoutIfNeeded()
        
        return scrollView
    }
    
    //MARK: Export to PDF
    //MARK: Completion Handler will send status and URL
    func exportPDF<Content: View>(@ViewBuilder content: @escaping ()->Content,completion: @escaping (Bool,URL?)->()){
        
        //MARK: Temp URL
        let documentDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        //MARK: To generate new file when ever it is generated
        let outputFileURL = documentDirectory.appendingPathComponent("Yourpdfname\(UUID().uuidString).pdf")
        
        //MARK: PDF ViewBuilder
        let pdfView = convertToScrollView {
            content()
        }
        pdfView.tag = 1009
        let size = pdfView.contentSize
        
        pdfView.frame = CGRect(x: 0, y: getSafeArea().top, width: size.width, height: size.height)
        
        //MARK: Attaching to Root View and rendering the pdf
        getRootController().view.insertSubview(pdfView, at: 0)
        
        //MARK: Rendering Pdf
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do{
            
            try renderer.writePDF(to: outputFileURL, withActions: { context in
                
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            
            completion(true, outputFileURL)
        }
        catch {
            completion(false, nil)
            print(error.localizedDescription)
        }

    
    // Removing the added View
    getRootController().view.subviews.forEach { view in
        if view.tag == 1009 {
            print("Removed")
            
            view.removeFromSuperview()
        }
    }
}
    
    func screenBounds()->CGRect{
        return UIScreen.main.bounds
    }
    func getRootController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
            
        }
        return root
    }


func getSafeArea() -> UIEdgeInsets {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
        return .zero
    }
    guard let safeArea = screen.windows.first?.safeAreaInsets else {
        return .zero
        
    }
    return safeArea
    }
}
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self.edgesIgnoringSafeArea(.all))
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
