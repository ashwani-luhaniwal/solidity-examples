/*
    The following is an extremely basic example of a solidity contract.
    It takes a string upon creation and then repeats it when greet() is called.
*/

// The contract definition.
// A constructor of the same name will be automatically called on contract creation
contract GreeterContract {

    address creator;    // At first, an empty "address"-type variable of the name "creator". Will be set in the constructor.
    string greeting;    // At first, an empty "string"-type variable of the name "greeting". Will be set in constructor and can be changed.

    // The constructor
    // It accepts a string input and saves it to the contract's "greeting" variable.
    function Greeter(string _greeting) public {
        creator = msg.sender;
        greeting = _greeting;
    }

    function greet() constant returns(string) {
        return greeting;
    }

    function getBlockNumber() constant returns(uint) {
        // this doesn't have anything to do with the act of greeting
        // just demonstrating return of some global variable
        return block.number;
    }

    function setGreeting(string _newgreeting) {
        greeting = _newgreeting;
    }

    /********************
        Standard kill() function to recover funds
    *********************/
    function kill() {
        // only allows this action if theh account sending the signal is the creator
        if (msg.sender == creator) {
            // kills this contract and sends remaining funds back to creator
            suicide(creator);
        }
    }
}