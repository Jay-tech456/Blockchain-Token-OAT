import React, { useState } from "react";
import { Principal } from '@dfinity/principal';
import { token } from "../../../declarations/token";  

function Balance() {
  const [inputValue, setInput] = useState(""); 
  const [balanceResult, setBalance] = useState(""); 
  const [cryptoSymbol, setSymbol] = useState(""); 
  const [isHidden, setIsHidden] = useState(true); 

  async function handleClick() {
    const principal = Principal.fromText(inputValue); 
    const balance = await token.balanceOf(principal);
    const symbol = await token.getSymbol();
    setSymbol(symbol); 
    setBalance(balance.toLocaleString()) 
    setIsHidden(false); 
  }

  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          id="balance-principal-id"
          type="text"
          placeholder="Enter a Principal ID"
          value={inputValue}
          onChange= {(e) => setInput(e.target.value)}
        />
      </p>
      <p className="trade-buttons">
        <button
          id="btn-request-balance"
          onClick={handleClick}
        >
          Check Balance
        </button>
      </p>
      {/* Conditionally render the content based on the value of isHidden */}
      {isHidden ? null : (
        <p>This account has a balance of {balanceResult} {cryptoSymbol}</p>
      )}
    </div>
  );
}

export default Balance;
