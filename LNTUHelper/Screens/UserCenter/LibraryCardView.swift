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
        VStack(spacing: 20) {
            TextField("CardNumber", text: $libraryId)
                .keyboardType(.asciiCapable)
                .padding()
                .background(Color(.systemGreen))
                .cornerRadius(10)
                .padding(.horizontal)

            CBBarcodeView(data: $libraryId,
                          barcodeType: $barcodeType,
                          orientation: $rotate, onGenerated: nil)
                .frame(width: 300, height: 100, alignment: .center)
                .shadow(radius: 5)
            
            Text("读者条码: \(libraryId)")
                .foregroundColor(Color.gray)
            Spacer()
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
    }
}

struct LibraryCardView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryCardView()
    }
}
