import Principal "mo:base/Principal"; 
import HashMap "mo:base/HashMap"; 
import Debug "mo:base/Debug"; 
actor Token { 

    var owner : Principal = Principal.fromText("nbyth-x35ys-vsyta-xaawp-bu6zj-sbziw-dlri6-efbn7-6p564-l5fti-rqe");
    var totalSupply : Nat = 1000000000; 
    var symbol: Text = "OAT";

    // creating the ledger
    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash); 



    balances.put(owner, totalSupply);

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
        balances.put(msg.caller, amount);
        return "Success";
        
       } else { 
            return "Already Claimed"; 
       }
    }; 


    public func transfer(){ 
        
    }
}; 