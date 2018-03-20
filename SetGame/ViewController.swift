//
//  ViewController.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/17.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardsLeftLabel: UILabel!

    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func dealThreeCardsButtonTapped(_ sender: UIButton) {
        if cards.count + 3 <= cardButtons.count {
            addThreeCards()
        } else {
            showCardsLimitAlert()
        }
    }

    @IBAction func cardButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let index = cardButtons.index(of: sender) {
            if sender.isSelected == true {
                sender.layer.borderColor = UIColor.yellow.cgColor
                sender.layer.borderWidth = 3.0
                selectCard(with: cards[index])
            } else {
                sender.layer.borderColor = UIColor.clear.cgColor
                sender.layer.borderWidth = 0.0
                deselectCard(with: cards[index])
            }
        }

    }

    var deck = CardDeck()

    var cards = [Card]() {
        didSet {
            updateCardsDealed()
            cardsLeftLabel.text = NSLocalizedString(
                "Cards: \(deck.cards.count)",
                comment: "cards left count in VC"
            )
            if cards.count == 0 {
                showNewGameAlert()
            }
        }
    }

    var chosenCards = [Card]() {
        didSet {
            print("chosen Cards didSet with \(chosenCards.count) cards")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameStart()

    }

    func selectCard(with card: Card) {
        assert(chosenCards.count < 3, "3 chosenCards at most")
        chosenCards.append(card)
        if chosenCards.count == 3 {
            let isSet = isCardsMatchedSet()

//            if isSet {
            if 0 == 0 {
                print("Set matched")
                for card in chosenCards {
                    if let index = self.cards.index(of: card) {
                        self.cards.remove(at: index)
                        if self.cards.count < 12 && deck.cards.count > 0 {
                            if let card = deck.draw() {
                                self.cards.insert(card, at: index)
                            }
                        }
                    }

                }
                self.chosenCards = []
            } else {
                print("Set not matched")
                chosenCards = []
                updateCardsDealed()
            }
        }
    }

    func deselectCard(with card: Card) {
        assert(chosenCards.count > 0 && chosenCards.count < 3, "deselect card only allowed when 1 or 2 card(s) are chosen")
        if let index = chosenCards.index(of: card) {
            chosenCards.remove(at: index)
        } else {
            print("the card is not in chosen cards")
        }
    }

    func isCardsMatchedSet() -> Bool {
        assert(
            self.chosenCards.count == 3,
            "\(self.chosenCards.count) cards cannot be a set, a set of cards consist of 3 cards"
        )

        var cardFeatureCheckSum: [Int] = Array(
            repeating: 0,
            count: CardFeatureItem.all.count
        )

        for card in chosenCards {
            for item in CardFeatureItem.all {
                let index = item.rawValue
                cardFeatureCheckSum[index] += card.features[index].rawValue
            }
        }

        // check set match
        for checksum in cardFeatureCheckSum {
            if checksum % 3 != 0 { return false }
        }
        return true
    }

    func showCardsLimitAlert() {
        let alert = UIAlertController(
            title: "cards number limits",
            message: "Due to screen limit, cards can not be added",
            preferredStyle: UIAlertControllerStyle.alert
        )
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (action) in
                self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func newGame() {
        deck = CardDeck()
        gameStart()
    }

    func showNewGameAlert() {
        let alert = UIAlertController(title: "New Game", message: "Good Job! Try new game?", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            self.newGame()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func addThreeCards() {
        for _ in 0..<3 {
            if let card = deck.draw() {
                cards.append(card)
            }
        }
    }

    func gameStart() {
        for _ in 0..<12 {
            if let card = deck.draw() {
                cards.append(card)
            }
        }
    }

    func updateCardsDealed() {
        for cardIndex in cardButtons.indices {
            if Int(cardIndex) < cards.endIndex {
                cardButtons[cardIndex].isEnabled = true
                cardButtons[cardIndex].backgroundColor = .white
                cardButtons[cardIndex].isSelected = false
                cardButtons[cardIndex].layer.borderColor = UIColor.clear.cgColor
                cardButtons[cardIndex].layer.borderWidth = 0.0

                let card = cards[cardIndex]
                let title = getCardPip(with: card)
                cardButtons[cardIndex].setAttributedTitle(title, for: .normal)
                cardButtons[cardIndex].setAttributedTitle(title, for: .selected)
            } else {
                cardButtons[cardIndex].backgroundColor = .clear
                cardButtons[cardIndex].setTitle(nil, for: .normal)
                cardButtons[cardIndex].setAttributedTitle(nil, for: .normal)
                cardButtons[cardIndex].isEnabled = false
            }
        }

    }

    func getCardPip(with card: Card) -> NSAttributedString? {
        let symbolIndex = CardFeatureItem.symbol.rawValue
        let colorIndex = CardFeatureItem.color.rawValue
        let numberIndex = CardFeatureItem.number.rawValue
        let shadingIndex = CardFeatureItem.shading.rawValue

        guard
            let symbol = SetSymbol(rawValue: card.features[symbolIndex].rawValue),
            let number = SetNumber(rawValue: card.features[numberIndex].rawValue),
            let color = SetColor(rawValue: card.features[colorIndex].rawValue),
            let shading = SetShading(rawValue: card.features[shadingIndex].rawValue)
        else {
            print("invalid card")
            return nil
        }
//        print("symbol: " + symbol.description)
//        print("color: \(color.uiColor)")
//        print("number: " + number.description)
//        print("shading: " + shading.description)

        let title = String(
            repeating: symbol.description,
            count: Int(number.description)!
        )

        let attribute = NSAttributedString(
            string: title,
            attributes: [
                NSAttributedStringKey.strokeColor : color.uiColor,
                NSAttributedStringKey.strokeWidth : -8,
                NSAttributedStringKey.foregroundColor : color.uiColor.withAlphaComponent(shading.alpha)
            ]
        )

        return attribute

    }



}

