import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("시작 화면")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: WhenView()) {
                    Text("시작하기")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("StartView")
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
