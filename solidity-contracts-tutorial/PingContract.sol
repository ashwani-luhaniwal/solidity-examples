// Contract can get non-constant return values from functions in other contracts. (Whereas you can't from web3/geth.)
// These two contracts are meant to test this. Like so:

// 1. Deploy Pong with a ponval.
// 2. Deploy Ping, giving it the address of Pong.
// 3. Call Ping.getPongvalRemote() using a sendTransaction...
// 4. ... which retreives the values of pongval from Pong.
// 5. If successful Ping.getPongval() should return the value from step 1.

contract PongvalRetriever {
    int8 pongval_tx_retrieval_attempted = 0;
    // tells Ping how to intract with Pong.
    function getPongvalTransactional() public returns(int8) {
        pongval_tx_retrieval_attempted = -1;
        return pongval_tx_retrieval_attempted;
    }
}

contract Ping is PongvalRetriever {

    int8 pongval;
    PongvalRetriever pvr;
    address creator;

    // Deploy Ping, giving it the address of Pong.
    function Ping(PongvalRetriever _pongAddress) {
        creator = msg.sender;
        pongval = -1;
        pvr = _pongAddress;
    }

    // Transactionally retrieve pongval from Pong.
    function getPongvalRemote() {
        pongval = pvr.getPongvalTransactional();
    }

    // Get pongval (which was previously retrieved from Pong via transaction)
    function getPongvalConstant() constant returns(int8) {
        return pongval;
    }

    // Functons to get and set pongAddress just in case
    function setPongAddress(PongvalRetriever _pongAddress) {
        pvr = _pongAddress;
    }

    function getPongAddress() constant returns(address) {
        return pvr;
    }

    // For double-checking this contract's address
    function getAddress() returns(address) {
        return this;
    }

    // kill to recover funds
    function kill() {
        if (msg.sender == creator) {
            suicide(creator);
        }
    }
}