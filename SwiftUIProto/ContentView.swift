//
//  ContentView.swift
//  SwiftUIProto
//
//  Created by Vikash Hart on 10/22/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var currentMode
    @State var rTarget: Double
    @State var gTarget: Double
    @State var bTarget: Double
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false

    private func computeScore() -> Int {
      let rDiff = rGuess - rTarget
      let gDiff = gGuess - gTarget
      let bDiff = bGuess - bTarget
      let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
      return Int((1.0 - diff) * 100.0 + 0.5)
    }

    func getColorValue() -> Double {
        return Double.random(in: 0..<1)
    }

    func resetGame() {
        resetSliders()
        resetColor()
        showAlert = false
    }

    private func resetSliders() {
        rGuess = 0.5
        gGuess = 0.5
        bGuess = 0.5
    }

    private func resetColor() {
        rTarget = getColorValue()
        gTarget = getColorValue()
        bTarget = getColorValue()
    }

    var body: some View {
        VStack {
            Button(action: {
                resetGame()
            }, label: {
                Text("New Game")
                    .foregroundColor(.red)
            })

            HStack {
                // Target color block
                  VStack {
                    Rectangle().foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                    Text("Match this color")
                        .accentColor(currentMode == .dark ? Color.white : Color.black)
                  }
                // Guess color block
                  VStack {
                    Rectangle().foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                    HStack {
                        HStack {
                          Text("R: \(Int(rGuess * 255.0))")
                            .accentColor(currentMode == .dark ? Color.white : Color.black)
                          Text("G: \(Int(gGuess * 255.0))")
                            .accentColor(currentMode == .dark ? Color.white : Color.black)
                          Text("B: \(Int(bGuess * 255.0))")
                            .accentColor(currentMode == .dark ? Color.white : Color.black)
                        }
                    }
                  }
            }

            Button(action: {
                self.showAlert = true
            }) {
                Text("Try Guess!")
                    .foregroundColor(.purple)
            }
            .alert(isPresented: $showAlert) {
              Alert(title: Text("Your Score"), message: Text("\(computeScore())"))
            }

            VStack {
                ColorSlider(value: $rGuess, textColor: .red)
                ColorSlider(value: $gGuess, textColor: .green)
                ColorSlider(value: $bGuess, textColor: .blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView(rTarget: Double.random(in: 0..<1),
                        gTarget: Double.random(in: 0..<1),
                        bTarget: Double.random(in: 0..<1),
                        rGuess: 0.5,
                        gGuess: 0.5,
                        bGuess: 0.5)
                .preferredColorScheme($0)
                }
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color

    var body: some View {
        HStack {
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
            Text("255")
                .foregroundColor(textColor)
        }.padding()
    }
}
