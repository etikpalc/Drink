import SwiftUI

struct HomeView: View {
    @Binding var startDate: Date // WhenView에서 전달된 시작 날짜
    @Binding var selectedDays: Int // CheatingView에서 전달된 치팅데이 횟수
    
    @State private var currentDay = 0 // 현재 진행된 일수를 저장할 상태 변수
    @State private var showStopView = false // StopView를 전체 화면으로 표시할 상태 변수
    
    private let squareSize: CGFloat = 40 // 정사각형의 크기
    private let horizontalSpacing: CGFloat = 6 // 가로 간격
    private let verticalSpacing: CGFloat = 50 // 세로 간격
    private let rows = 4 // 세로 열 수
    private let columns = 7 // 가로 열 수
    
    // 타이머 설정 (1초마다 currentDay를 업데이트)
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            Text("등록한 날짜부터 한 달 주차")
                .font(.title)
                .padding()
            
            // 선택한 치팅데이 횟수 표시
            Text("치팅데이 횟수: \(selectedDays)일")
                .font(.headline)
                .padding()
            
            // 한 달 동안의 주차 목록 출력
            ForEach(generateWeeks(for: startDate), id: \.self) { week in
                Text(week)
                    .font(.headline)
                    .padding(.vertical, 5)
            }
            
            // 정사각형 그리기
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(squareSize), spacing: horizontalSpacing), count: columns), spacing: verticalSpacing) {
                ForEach(0..<rows * columns, id: \.self) { index in
                    Rectangle()
                        .fill(index < currentDay ? Color.blue : Color.gray)
                        .frame(width: squareSize, height: squareSize)
                        .animation(.easeInOut, value: currentDay) // 애니메이션 추가
                }
            }
            .padding()
            
            Spacer()
            
            // StopView로 넘어가는 버튼
            Button(action: {
                showStopView = true
            }) {
                Text("StopView로 이동")
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .fullScreenCover(isPresented: $showStopView) {
            StopView()
        }
        .onReceive(timer) { _ in
            // 하루마다 currentDay를 업데이트 (여기서는 매초마다 업데이트 예제)
            if currentDay < selectedDays {
                currentDay += 1
            }
        }
    }
    
    // 등록된 날짜를 기준으로 한 달 동안의 주차 목록을 생성
    func generateWeeks(for date: Date) -> [String] {
        var weeks: [String] = []
        let calendar = Calendar.current
        var currentStartOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        
        // 한 달(4주) 동안의 주차 계산
        for i in 0..<4 {
            let weekEnd = calendar.date(byAdding: .day, value: 6, to: currentStartOfWeek)!
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            
            let weekString = "\(i + 1)주차: \(formatter.string(from: currentStartOfWeek)) - \(formatter.string(from: weekEnd))"
            weeks.append(weekString)
            
            // 다음 주로 이동
            currentStartOfWeek = calendar.date(byAdding: .day, value: 7, to: currentStartOfWeek)!
        }
        
        return weeks
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(startDate: .constant(Date()), selectedDays: .constant(4))
    }
}
