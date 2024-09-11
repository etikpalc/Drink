import SwiftUI

struct CheatingView: View {
    @State var startDate: Date // WhenView에서 전달된 시작 날짜
    @State private var selectedDays = 1 // 선택된 치팅데이 횟수를 저장할 상태 변수
    let dayOptions = Array(1...4) // 선택할 수 있는 치팅데이 횟수 옵션 배열
    @State private var navigateToHomeView = false // HomeView로 이동할지 여부를 제어하는 상태 변수
    
    var body: some View {
        VStack {
            Text("치팅데이 횟수를 선택하세요")
                .font(.title)
                .padding()
            
            // Picker를 사용하여 치팅데이 횟수를 선택
            Picker("치팅데이 횟수", selection: $selectedDays) {
                ForEach(dayOptions, id: \.self) { day in
                    Text("\(day)일")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // 선택한 치팅데이 횟수 표시
            Text("선택한 치팅데이 횟수: \(selectedDays)일")
                .font(.headline)
                .padding()
            
            Spacer()
            
            // HomeView로 넘어가는 버튼
            NavigationLink(isActive: $navigateToHomeView) {
                HomeView(startDate: $startDate, selectedDays: $selectedDays)
            } label: {
                
                Button {
                    navigateToHomeView = true
                    UserDefaults.standard.set(true, forKey: "isSet")
                    UserDefaults.standard.set(startDate, forKey: "startDate")
                    UserDefaults.standard.set(selectedDays, forKey: "selectedDays")
                    
                } label: {
                    Text("다음")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
        .navigationTitle("CheatingView")
    }
}

struct CheatingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheatingView(startDate: Date())
        }
    }
}
