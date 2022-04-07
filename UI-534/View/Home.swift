//
//  Home.swift
//  UI-534
//
//  Created by nyannyan0328 on 2022/04/07.
//

import SwiftUI

struct Home: View {
    @State var showDetail : Bool = false
    @Environment(\.colorScheme) var scheme
    @Namespace var animaiton
    
    @State var currentItem : Today?
    
    @State var animationView : Bool = false
    
    @State var animatedView : Bool = false
    
    @State var offset : CGFloat = 0

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing:0){
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Monday 4 April")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.gray)
                        
                        Text("Today")
                            .font(.largeTitle.weight(.heavy))
                        
                    }
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "person.crop.circle.fill")
                            .font(.largeTitle)
                    }

                }
                .padding(.horizontal)
                .opacity(showDetail ? 0 : 1)
                
                ForEach(todayItems){today in
                    
                    Button {
                        
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            currentItem = today
                            showDetail = true
                            
                            
                        }
                        
                    } label: {
                        
                        cardView(today: today)
                            .scaleEffect(currentItem?.id == today.id  && showDetail ? 1 : 0.95)
                    }
                    .buttonStyle(buttonModifier())
                    .opacity(showDetail ? (currentItem?.id == today.id ? 1 : 0) : 1)
                    .zIndex(currentItem?.id == today.id && showDetail ? 10 : 0)

                }
                
                
            }
            
        }
        .overlay {
            
            if let currentItem = currentItem,showDetail {
                
                
                DetailView(today: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
            
        }
    }
    @ViewBuilder
    func DetailView(today : Today)->some View{
        
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing:20){
                
                cardView(today: today)
                
                VStack{
                    
                    Text(dummyText)
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(5)
                    
                    
                    Divider()
                        .background(.blue)
                    
                    
                    Button {
                        
                    } label: {
                        
                        Label {
                            
                            Text("Share Story")
                            
                        } icon: {
                            
                            Image(systemName: "square.and.arrow.up.fill")
                        }

                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(
                    
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.regularMaterial)
                    
                    )
                    .padding(.top,10)

                    
                    
                }
                .padding(.horizontal)
                .offset(y: offset > 0 ? offset : 0)
                .opacity(animationView ? 1 : 0)
                .scaleEffect(animationView ? 1 : 0,anchor:.top)
            }
            .offset(y:offset > 0 ? -offset : 0)
            .offset(offset: $offset)
            
        }
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing, content: {
            
            Button {
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                    
                    showDetail = false
                    currentItem = nil
                    
                    
                }
                
                
            } label: {
                
                Image(systemName: "xmark")
                    .padding(10)
                    .foregroundColor(.black)
                    .background(
                    Circle()
                        .fill(.white)
                        .shadow(radius: 5)
                    
                    )
            }
            .padding(.trailing,20)
            .padding(.top,getSafeArea().top)
            .offset(x: -10)

            
            
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                
            animationView = true
                
                
            }
        }
        
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                
           animationView  = true
                
                
            }
        }
        
        
        
    }
    @ViewBuilder
    func cardView(today : Today)->some View{
        
        VStack(spacing:0){
            
            ZStack(alignment:.topLeading){
                
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    Image(today.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(radi: 10, corner: [.topLeft,.topRight]))
                }
                .frame(height:400)
                
                
                let color : Color = (scheme == .dark ? .black : .white)
                
                LinearGradient(colors: [
                
                
                    .black.opacity(0.2),
                    .gray.opacity(0.1),
                    color.opacity(0.3),
                    color.opacity(0.2),
                    
                    
                
                
                ] + Array(repeating: color.opacity(0.1), count: 3), startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(today.platformTitle.uppercased())
                        .font(.title3.weight(.semibold))
                        
                    
                    Text(today.platformTitle)
                        .font(.largeTitle.weight(.black))
                    
                }
                .padding([.leading,.top])
                .offset(y: currentItem?.id == today.id && animationView ? getSafeArea().top : 0)
                
            }
            
            HStack(spacing:20){
                
                Image(today.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    
                    Text(today.platformTitle)
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.gray)
                    
                    
                    Text(today.appName)
                        .font(.title.weight(.heavy))
                    
                    Text(today.appDescription)
                        .font(.callout)
                        .foregroundColor(.gray)
                    
                    
                }
                .frame(maxWidth:.infinity,alignment: .leading)
                
                
                Button {
                    
                } label: {
                    
                    Text("Get")
                        .font(.title2)
                        .padding(.vertical,10)
                        .padding(.horizontal)
                        .background(
                        
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.ultraThinMaterial)
                        )
                }
              

            }
            .padding([.horizontal,.bottom])
            .background(
            
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color("BG"))
            
            )
          
    
           
            
        }
        .padding()
        .matchedGeometryEffect(id: today.id, in: animaiton)
      
        
        
    }
    
  
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct buttonModifier : ButtonStyle{
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

extension View{
    
    func getSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{return .zero}
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{return .zero}
        
        return safeArea
    }
    
    func offset(offset : Binding<CGFloat>) -> some View{
        
        
        return self
            .overlay {
                
                
                GeometryReader{proxy in
                    
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                    
                }
                .onPreferenceChange(OffsetKey.self) { value in
                    offset.wrappedValue = value
                }
            }
    }
}

struct OffsetKey : PreferenceKey{
    
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
        value = nextValue()
        
    }
}


