// Supposedly, contracts can get non-constant return values from other contracts. (Whereas you can't from web3/geth)
// These two contracts are meant to test this. Like so:

// 1. Deploy Pong with a pongval.
// 2. Deploy Ping, giving it the address of Pong.
// 3. Call Ping.getPongvalRemote() using a sendTransaction...
// 4. ... which retrieves the value of pongval from Pong.
// 5. If successful Ping.getPongval() should return the value from step 1.

contract Pong {

    address creator;
    int8 pongval;
    int8 pongval_tx_retrieval_attempted = 0;

    // Deploy Pong
    function Pong(int8 _pongval) {
        creator = msg.sender;
        pongval = _pongval;
    }
    
    // Transactionally return pongval, overriding PongvalRetriever
    function getPongvalTransactional() public returns(int8) {
        pongval_tx_retrieval_attempted = 1;
        return pongval;
    }

    // pongval getter/setter
    function getPongvalConstant() public constant returns(int8) {
        return pongval;
    }

    function setPongval(int8 _pongval) {
        pongval = _pongval;
    }

    function getPongvalTxRetrievalAttempted() constant returns(int8) {
        return pongval_tx_retrieval_attempted;
    }

    // For double-checking this contract's address
    function getAddress() constant returns(address) {
        return this;
    }

    // kill to recover funds
    function kill() {
        if (msg.sender == creator) {
            suicide(creator);
        }
    }
}