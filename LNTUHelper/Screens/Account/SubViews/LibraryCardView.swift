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
    
    @State var libraryId = "0"
    @State var barcodeType = CBBarcodeView.BarcodeType.barcode128
    @State var rotate = CBBarcodeView.Orientation.up
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("请输入图书卡卡号", text: $libraryId)
                .foregroundColor(Color.white)
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
                .foregroundColor(Color.secondary)
            Spacer()
        }
        .resignKeyboardOnDragGesture()
        .onAppear(perform: {
            self.libraryId = UserDefaults.standard.object(forKey: SettingsKey.libraryId.rawValue) as? String ?? "0"
        })
        .onDisappear(perform: {
            UserDefaults.standard[.libraryId] = self.libraryId
        })
    }
}

struct LibraryCardView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryCardView()
    }
}
