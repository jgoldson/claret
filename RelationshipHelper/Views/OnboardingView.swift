import SwiftUI

struct OnboardingView: View {
    
    var subviews = [
        UIHostingController(rootView: Subview(imageString: "CoupleInLove", system: false)),
        UIHostingController(rootView: Subview(imageString: "Dancing2", system: false)),
        UIHostingController(rootView: Subview(imageString: "CoupleCircle", system: false)),
        UIHostingController(rootView: Subview(imageString: "CoupleGay", system: false)),
        UIHostingController(rootView: Subview(imageString: "Hug2", system: false))
    ]
    
    var titles = ["We're here to help", "A tiny nudge when you need it", "Love Languages", "Set your Goal Frequency", "Love Score"]
    
    var captions =  [
        "Lasting relationships, like anything worthwhile, take intentional commitment over time. Everyone gives and receives love differently, but with a little insight into these differences, we can be confidently equipped to communicate love well.",
                     "You love your partner but sometimes life gets in the way of showing it. We provide small reminders to make sure that doesn't happen while using your partner's love languages to ensure they understand how you feel",
                     "The five love languages are five different ways of expressing and receiving love: words of affirmation, quality time, receiving gifts, acts of service, and physical touch. Not everyone communicates love in the same way, and likewise, people have different ways they prefer to receive love.",
        "First, you'll set your goals for each of the love languages. Ask your partner what their love languages are, or better yet have them take a quiz to know what they truly value. You can always modify these reminders from the settings menu",
            "Try to accomplish at least 3 a week to keep your love score from decreasing. The app will provide a suggestion but feel free to get creative and come up with your own way to show your partner your love. No one knows them better than you!"
    ]
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var currentPageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                //.frame(height: 500)
            Group {
                Text(titles[currentPageIndex])
                    .font(.title)
                    .padding(.leading, 24)
                Text(captions[currentPageIndex])
                .font(.subheadline)
                .foregroundColor(.gray)
                    //.frame(width: 300, height: 200, alignment: .leading)
                .lineLimit(nil)
                    .padding(.leading, 24)
            }
                .padding()
            HStack {
                PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                Spacer()
                if currentPageIndex == 4 {
                    Button(action: {
                        withAnimation {
                            self.viewRouter.currentPage = "frequencyView"
                        }
                    }) {
                        Text("Lets Get Started")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            
                        ButtonContent()
                    }
                } else {
                    Button(action: {
                        if self.currentPageIndex+1 == self.subviews.count {
                            self.currentPageIndex = 0
                        } else {
                            self.currentPageIndex += 1
                        }
                    }) {
                        ButtonContent()
                    }
                }
            }
                .padding()
        }
    }
}

struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
            .resizable()
            .foregroundColor(Color(K.Color.BrandColor2))
            .frame(width: 30, height: 30)
            .padding()
            .background(Color(K.Color.BrandColor0))
            .cornerRadius(30)
    }
}

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(ViewRouter())
    }
}
#endif
