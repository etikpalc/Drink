import SwiftUI

struct StopView: View {
    var body: some View {
        VStack {
            Text("다시 도전해봐요")
                .padding(.top, 100)
            
            Spacer() // 위쪽 여백을 차지하여 버튼을 하단에 위치시킵니다.
            
            // "다시 도전하기" 버튼
            Button(action: {
                // 버튼 클릭 시 동작을 여기에 작성합니다.
                print("다시 도전하기 버튼 tapped!")
            }) {
                Text("다시 도전하기")
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("StopView")
    }
}

struct StopView_Previews: PreviewProvider {
    static var previews: some View {
        StopView()
    }
}
