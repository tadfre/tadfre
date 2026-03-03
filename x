<!DOCTYPE html>
<html lang="cs">
<head>
    <meta charset="UTF-8">
    <title>GitHub Casino - Blackjack</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #1a3a32; color: white; text-align: center; }
        .game-container { max-width: 600px; margin: 50px auto; background: #2d5a4c; padding: 20px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .cards { font-size: 24px; font-weight: bold; min-height: 40px; margin: 10px 0; }
        button { padding: 10px 20px; font-size: 16px; cursor: pointer; border: none; border-radius: 5px; background: #e67e22; color: white; transition: 0.3s; }
        button:hover { background: #d35400; }
        button:disabled { background: #7f8c8d; cursor: not-allowed; }
        #message { font-size: 20px; font-weight: bold; color: #f1c40f; margin: 20px 0; }
    </style>
</head>
<body>

<div class="game-container">
    <h1>🃏 GitHub Blackjack</h1>
    
    <div>
        <h3>Dealer: <span id="dealer-score">?</span></h3>
        <div id="dealer-cards" class="cards"></div>
    </div>

    <hr>

    <div>
        <h3>Tvoje karty: <span id="player-score">0</span></h3>
        <div id="player-cards" class="cards"></div>
    </div>

    <div id="message">Klikni na "Nová hra"</div>

    <button id="btn-new" onclick="startNewGame()">Nová hra</button>
    <button id="btn-hit" onclick="hit()" disabled>Další kartu (Hit)</button>
    <button id="btn-stay" onclick="stay()" disabled>Stačí (Stay)</button>
</div>

<script>
    let deck = [], playerHand = [], dealerHand = [], gameOver = false;

    function createDeck() {
        const values = ['2','3','4','5','6','7','8','9','10','J','Q','K','A'];
        deck = [];
        for (let i = 0; i < 4; i++) values.forEach(v => deck.push(v));
    }

    function getCardValue(card) {
        if (['J', 'Q', 'K'].includes(card)) return 10;
        if (card === 'A') return 11;
        return parseInt(card);
    }

    function calculateScore(hand) {
        let score = hand.reduce((sum, card) => sum + getCardValue(card), 0);
        let aces = hand.filter(c => c === 'A').length;
        while (score > 21 && aces > 0) { score -= 10; aces--; }
        return score;
    }

    function render() {
        document.getElementById('player-cards').innerText = playerHand.join(' ');
        document.getElementById('player-score').innerText = calculateScore(playerHand);
        document.getElementById('dealer-cards').innerText = gameOver
