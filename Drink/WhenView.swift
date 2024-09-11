import SwiftUI

struct WhenView: View {
    @State private var selectedDate = Date() // 기본값은 현재 날짜
    @State private var showDatePicker = false // 시트 표시 여부를 제어하는 상태 변수
    @State private var navigateToCheatingView = false // CheatingView로의 네비게이션 상태 변수
    private let today = Date() // 오늘 날짜
    
    var body: some View {
            VStack {
                Text("날짜를 선택하세요")
                    .font(.title)
                    .padding()
                
                // 선택한 날짜 표시
                Text("선택한 날짜: \(formattedDate)")
                    .font(.headline)
                    .padding()
                
                // 날짜 선택기 버튼
                Button(action: {
                    showDatePicker.toggle() // 버튼을 눌렀을 때 시트가 올라오도록
                }) {
                    Text(formattedDate) // 버튼 텍스트에 선택한 날짜 표시
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                // CheatingView로 넘어가는 버튼 (선택한 날짜 전달)
                NavigationLink(destination: CheatingView(startDate: selectedDate), isActive: $navigateToCheatingView) {
                    Text("다음")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("WhenView")
            .overlay(
                Group {
                    if showDatePicker {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    showDatePicker = false
                                }
                            }
                        
                        VStack {
                            Spacer()
                            VStack {
                                Text("날짜를 선택하세요")
                                    .font(.headline)
                                    .padding()

                                DatePicker("날짜 선택", selection: $selectedDate, in: ...today, displayedComponents: [.date])
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    .padding()

                                Button(action: {
                                    withAnimation {
                                        showDatePicker = false
                                    }
                                }) {
                                    Text("완료")
                                        .font(.headline)
                                        .padding()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                .padding()
                            }
                            .background(Color.white)
                            .cornerRadius(20)
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                        }
                        .background(Color.white)
                        .cornerRadius(20)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut)
                    }
                }
            )
        }
    
    // 날짜 형식 지정
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: selectedDate)
    }
}


struct WhenView_Previews: PreviewProvider {
    static var previews: some View {
        WhenView()
    }
}
