////
////  GradePointAverageView.swift
////  LNTUHelper
////
////  Created by LiaoGuoYin on 2020/10/29.
////
//
//import SwiftUI
//
//struct GradePointAverageView: View {
//    @Binding var gpa: GradeResponseDataGPA
//    var body: some View {
//        VStack {
//            Text("\(gpa.semester)")
//                .font(.system(size: 24, design: .monospaced))
//                .fontWeight(.heavy)
//                .padding(.bottom)
//
//            HStack(spacing: 28) {
//                Text("科目：\(gpa.courseCount)")
//                Text("学分：\(String(format: "%.1f", gpa.creditTotal))")
//                Text("绩点：\(String(format: "%.4f", gpa.gradePointAverage))")
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//        .foregroundColor(Color(.white))
//        .background(Color("primary"))
//        .cornerRadius(10)
//        .shadow(color: Color(.systemBlue).opacity(0.2), radius: 5, x: 5, y: 10)
//    }
//}
//
//struct GradePointAverageView_Previews: PreviewProvider {
//    static var previews: some View {
//        let demoData = """
//            {"semester": "2020-秋",
//             "gradePointAverage": 4.1389,
//             "weightedAverage": 92.2426,
//             "gradePointTotal": 111.75,
//              "scoreTotal": 2490.55,
//              "creditTotal": 27,
//              "courseCount": 11
//            }
//            """.data(using: .utf8)!
//        let demoGPA = try! JSONDecoder().decode(GradeResponseDataGPA.self, from: demoData)
//        GradePointAverageView(gpa: .constant(demoGPA))
//    }
//}
