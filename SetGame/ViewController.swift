//
//  ViewController.swift
//  SetGame
//
//  Created by 典萱 高 on 2018/3/17.
//  Copyright © 2018年 LostRfounds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game = Set()
    var numberOfCardDealtAtFirst: Int = 12
    var isMoreRoomFor3Cards: Bool {
        return (game.cardsOnTable.count + 3 <= cardButtons.count)
    }

    @IBOutlet weak var cardsLeftLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dealThreeCardsButton: UIButton!

    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func dealThreeCardsButtonTapped(_ sender: UIButton) {
        if isMoreRoomFor3Cards && !game.deck.isEmpty {
            if game.chosenCards.count == 3 && game.isCardsMatchedSet(with: game.chosenCards) {
                game.removeMatchedSetCardsAndDeal3More(
                    with: game.chosenCards,
                    completionHandler: updateCardsDealed
                )
            } else {
                game.add3Cards(with: updateCardsDealed)
            }
        } else {
            showCardsLimitAlert()
        }
    }

    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        game.newGameWithCard(number: numberOfCardDealtAtFirst, updateCardsDealed)
    }

    func showCardSelectedStatus(with sender: UIButton) {
        if sender.isSelected {
            sender.layer.borderColor = UIColor.yellow.cgColor
            sender.layer.borderWidth = 3.0
        } else {
            sender.layer.borderColor = UIColor.clear.cgColor
            sender.layer.borderWidth = 0.0
        }
    }

    @IBAction func cardButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if let index = cardButtons.index(of: sender) {
            showCardSelectedStatus(with: sender)
            if sender.isSelected == true {
                game.selectCard(
                    with: game.cardsOnTable[index],
                    completionHandler: updateCardsDealed
                )
            } else {
                game.deselectCard(with: game.cardsOnTable[index])
            }
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        game.newGameWithCard(number: numberOfCardDealtAtFirst, updateCardsDealed)

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

    func showNewGameAlert() {
        let alert = UIAlertController(title: "New Game", message: "Good Job! Try new game?", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            self.game.newGameWithCard(number: self.numberOfCardDealtAtFirst, self.updateCardsDealed)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func updateCardsDealed() {
        for cardIndex in cardButtons.indices {
            let cardButton = cardButtons[cardIndex]
            if Int(cardIndex) < game.cardsOnTable.endIndex {
                let card = game.cardsOnTable[cardIndex]
                let title = getCardPip(with: card)

                cardButton.isEnabled = true
                cardButton.backgroundColor = .white
                cardButton.isSelected = card.isSelected
                showCardSelectedStatus(with: cardButton)

                cardButton.setAttributedTitle(title, for: .normal)
                cardButton.setAttributedTitle(title, for: .selected)
            } else {
                cardButton.backgroundColor = .clear
                cardButton.setTitle(nil, for: .normal)
                cardButton.setAttributedTitle(nil, for: .normal)
                cardButton.isEnabled = false
            }
        }
        cardsLeftLabel.text = NSLocalizedString(
            "Cards: \(game.deck.cards.count)",
            comment: "cards left count in VC"
        )

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

