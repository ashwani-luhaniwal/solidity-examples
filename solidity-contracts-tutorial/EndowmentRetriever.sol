
contract EndowmentRetriever {

    address creator;
    uint contract_creation_value;   // original endowment 

    function EndowmentRetriever() public {
        creator = msg.sender;
        contract_creation_value = msg.value;    // the endowment of this contract in wei
    }

    // returns the original endowment of the contract
    function getContractCreationValue() constant returns(uint) {
        // set at creation time with "value: <someweivalue>"
        // this was the "balance" of the contract at creation time
        return contract_creation_value;
    }

    // send 1 ether to home
    function sendOneEtherHome() public {
        creator.send(1000000000000000000);
    }

    // kill to recover funds
    function kill() {
        if (msg.sender == creator) {
            suicide(creator);
        }
    }
}