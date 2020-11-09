//
//  LibraryCardView.swift
//  LNTUHelper
//
//  Created by LiaoGuoYin on 2020/11/7.
//

import SwiftUI
import CarBode
import AVFoundation //import to access barcode types you want to scan

struct LibraryCardView: View {
    
    @State var libraryId = ""
    @State var barcodeType = CBBarcodeView.BarcodeType.barcode128
    @State var rotate = CBBarcodeView.Orientation.up
    
    var body: some View {
        VStack {
            TextField("CardNumber", text: $libraryId)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color("primary"))
                .cornerRadius(8)
                .keyboardType(.asciiCapable)
            CBBarcodeView(data: $libraryId,
                          barcodeType: $barcodeType,
                          orientation: $rotate, onGenerated: nil)
                .frame(width: 300, height: 100, alignment: .center)
                .shadow(radius: 5)
            Text("读者条码: \(libraryId)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .resignKeyboardOnDragGesture()
        .onAppear(perform: {
            if let localLibraryId = UserDefaults.standard.string(forKey: "libraryId") {
                self.libraryId = localLibraryId
            }
        })
        .onDisappear(perform: {
            UserDefaults.standard.setValue(libraryId, forKey: "libraryId")
        })
        
        //            CBScanner(
        //                supportBarcode: .constant([.code128]), //Set type of barcode you want to scan
        //                scanInterval: .constant(5.0) //Event will trigger every 5 seconds
        //            ){
        //                self.studentBarCode = $0.value
        //                print("BarCodeType =",$0.type.rawValue, "Value =",$0.value)
        //            }
        //            onDraw: {
        //                print("Preview View Size = \($0.cameraPreviewView.bounds)")
        //                print("Barcode Corners = \($0.corners)")
        //
        //                //line width
        //                let lineWidth = 2
        //
        //                //line color
        //                let lineColor = UIColor.red
        //
        //                //Fill color with opacity
        //                //You also can use UIColor.clear if you don't want to draw fill color
        //                let fillColor = UIColor(red: 0, green: 1, blue: 0.2, alpha: 0.4)
        //
        //                //Draw box
        //                $0.draw(lineWidth: CGFloat(lineWidth), lineColor: lineColor, fillColor: fillColor)
        //            }
    }
}

struct LibraryCardView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryCardView()
    }
}
