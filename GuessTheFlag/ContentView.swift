//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nadya Farchana Fidaroina on 31/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var c = 8
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).foregroundColor(.secondary).font(.largeTitle.weight(.semibold))
                    } .frame(maxWidth: .infinity).padding(.vertical, 20).background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original).clipShape(Capsule()).shadow(radius: 5)
                        }
                    }
                }
            }
            }.alert(scoreTitle, isPresented: $showingScore) {
                if c>1 {
                    Button("Continue", action: askQuestion)
                } else {
                    Button("Restart Game", role: .destructive, action: resetGame)
                }
                } message: {
                    Spacer()
                    Text("Your score is \(score)").foregroundColor(.white).font(.title.bold())
                    Spacer()
                }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Corect"
            score+=1
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        if c>1 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            c-=1
        }
    }
    
    func resetGame () {
        c=8
        score=0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
