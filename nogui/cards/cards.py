import random


class Card:
    
    def __init__(self, rank, suit):
        self.rank = str(rank)
        self.suit = str(suit)
    
    def __repr__(self):
        return f'Card(rank={self.rank!r}, suit={self.suit!r})'
    
    def __str__(self):
        return f'{self.rank!s} of {self.suit!s}'


class Deck:
    
    ranks = ('A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K')
    suits = ('\u2665', '\u2666', '\u2663', '\u2660')
    
    def __init__(self, cards=None):
        if cards is None:
            self.cards = [Card(rank, suit) for suit in Deck.suits for rank in 
                          Deck.ranks]
        else:
            self.cards = list(cards)
            
    def __repr__(self):
        return f'Deck(cards={self.cards!r})'
    
    def __str__(self):
        return '\n'.join([str(card) for card in self.cards])
    
    def shuffle(self):
        return random.shuffle(self.cards)
        