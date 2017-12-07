/*
    Another very basic contract. It demonstrates that a contract can retrieve and store the
    balance of its creator address. Note that the creatorbalance value captured in the constructor is a snapshot in time.
    Later on, creator.balance will reflect whatever it is now.
*/

contract CreatorBalanceCheckContract {

    address creator;
    uint creatorbalance;    // TIP: uint is an alias for uint256. Ditto int and int256.

    // Constructor 
    function CreatorBalanceCheckContract() public {
        creator = msg.sender;   // msg is the global variable
        creatorbalance = creator.balance;
    }

    // Get contract address
    function getContractAddress() constant returns(address) {
        return this;
    }

    // Will return the creator's balance AT THE TIME OF THIS CONTRACT WAS CREATED.
    function getCreatorBalance() constant returns(uint) {
        return creatorbalance;
    }

    // Will return creator's balance NOW 
    function getCreatorDotBalance() constant returns(uint) {
        return creator.balance;
    }

    // Kill function to recover funds
    function kill() {
        if (msg.sender == creator) {
            suicide(creator);   // kills this contract and sends remaining funds back to creator 
        }
    }
    
}