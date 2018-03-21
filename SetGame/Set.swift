//
//  Set.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/20.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import Foundation

class Set {

    private(set) var deck: CardDeck = CardDeck()

    private(set) var cardsOnTable: [Card] = []
    private(set) var chosenCards: [Card] = []
    var score: Double = 0.0

    func newGameWithCard(number: Int, _ completionHandler: () -> ()) {
        self.deck = CardDeck()
        self.cardsOnTable = []
        self.chosenCards = []
        gameStartWithCardsNumber(number, completionHandler)
    }

    private func gameStartWithCardsNumber(_ cardNumber: Int,_ completionHandler: () -> ()) {
        assert(cardNumber > 0, "the number of cards dealt should be greater than 0, the input is \(cardNumber) now")
        for _ in 0..<cardNumber {
            if let card = deck.draw() {
                cardsOnTable.append(card)
            }
        }
        completionHandler()
    }

    func add3Cards(with completionHandler: () -> ()) {
        for _ in 0..<3 {
            if let card = deck.draw() {
                cardsOnTable.append(card)
            }
        }
        completionHandler()
    }

    func deselectCard(with card: Card) {
        if chosenCards.contains(card) {
            if let index = chosenCards.index(of: card) {
                chosenCards.remove(at: index)
            }
        }
    }

    func removeMatchedSetCardsAndDeal3More(with matchedCards: [Card], completionHandler: () -> ()) {
        assert(
            matchedCards.count == 3 && isCardsMatchedSet(with: matchedCards),
            "number of cards input is not 3 or they are not set"
        )
        for card in chosenCards {
            guard
                let index = cardsOnTable.index(of: card)
            else {
                print("chosen card not in cardsOnTable")
                print(card)
                continue
            }
            cardsOnTable.remove(at: index)
            if !deck.cards.isEmpty {
                if let newCard = deck.draw() {
                    cardsOnTable.insert(newCard, at: index)
                }
            }
        }
        completionHandler()
    }

    func selectCard(with card: Card, completionHandler: () -> ()) {
        if !chosenCards.contains(card) {
            if chosenCards.count == 3 {
                if isCardsMatchedSet(with: chosenCards) {
                    removeMatchedSetCardsAndDeal3More(with: chosenCards, completionHandler: completionHandler)
                }
                for card in chosenCards {
                    deselectCard(with: card)
                }
//                completionHandler()
            }
            chosenCards.append(card)
        }
    }

    func isCardsMatchedSet(with cards: [Card]) -> Bool {
        assert(cards.count == 3, "there are \(cards.count) cards, a set should consist of 3 cards")

        var cardFeatureCheckSums: [Int] = Array(
            repeating: 0,
            count: CardFeatureItem.all.count
        )

        for card in cards {
            for item in CardFeatureItem.all {
                let index = item.rawValue
                cardFeatureCheckSums[index] += card.features[index].rawValue
            }
        }

        for checksum in cardFeatureCheckSums {
            if checksum % 3 != 0 { return false }
        }
        return true
    }

    
}
