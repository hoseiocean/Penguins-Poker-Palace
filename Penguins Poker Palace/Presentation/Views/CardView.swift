struct CardView: View {
    let card: Card
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(card.symbol)  // Affiche le symbole de la carte
                .font(.largeTitle)
            Text(card.suit.emoji)  // Affiche l'emoji du suit de la carte
        }
        .padding()
        .background(isSelected ? Color.yellow : Color.white)  // Indique si la carte est sélectionnée
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}