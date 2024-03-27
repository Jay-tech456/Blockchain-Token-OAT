import Principal "mo:base/Principal"; 
import HashMap "mo:base/HashMap"; 
import Debug "mo:base/Debug"; 
import Iter "mo:base/Iter"; 
actor Token { 

    let owner : Principal = Principal.fromText("nbyth-x35ys-vsyta-xaawp-bu6zj-sbziw-dlri6-efbn7-6p564-l5fti-rqe");
    let totalSupply : Nat = 1000000000; 
    let symbol: Text = "OAT";

    // serialized data types 
    private stable var balanceEntries: [(Principal, Nat)] = []; 


    // creating the ledger
    private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash); 
    if(balances.size() < 1){ 
    balances.put(owner, totalSupply);
    };

    public query func balanceOf(who: Principal): async Nat { 
        let balance : Nat = switch (balances.get(who)){ 
            case null 0; 
            case (?result) result;
        }; 
        return balance;
    }; 

    public query func getSymbol() : async Text { 
        return symbol; 
    };

    public shared(msg) func payOut() : async Text{ 
       Debug.print(debug_show(msg.caller));
       if(balances.get(msg.caller) == null){ 
        let amount = 10000; 
        //balances.put(msg.caller, amount);
       let result = await transfer(msg.caller, amount); 

        return "Success";
        
       } else { 
            return "Already Claimed"; 
       }
    }; 


   public shared(msg) func transfer(to: Principal, amount: Nat): async Text {
    let fromBalance = await balanceOf(msg.caller);

    // If the balance has enough currency, then do the transaction, or else balance is insufficient
    if (fromBalance > amount) {
        let newFromBalance : Nat = fromBalance - amount;  
        balances.put(msg.caller, newFromBalance); 

        let toBalance = await balanceOf(to);
        let newToBalance = toBalance + amount;
        balances.put(to, newToBalance); 
        return "Success"; 
    } else { 
        Debug.print(debug_show(fromBalance));
        return "Insufficient Funds"; 
    }
};



system func preupgrade() { 
    // Iterate through the entire balanceEntries
    balanceEntries := Iter.toArray(balances.entries()); 
};

system func postupgrade(){ 
    let newBalances = HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);


    // type check to see how much supply we currently have 
    if(balances.size() < 1){ 
    balances.put(owner, totalSupply);
    }
}

};