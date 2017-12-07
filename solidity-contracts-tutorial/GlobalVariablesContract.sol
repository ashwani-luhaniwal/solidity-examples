/*
    This is a demonstration of the various global variables available to contracts.
*/

contract GlobalVariablesContract {

    address creator;

    function GlobalVariablesContract() public {
        creator = msg.sender;
    }

    // get CURRENT block miner's address
    // not necessarily the address of miner when this block was born
    function getCurrentMinerAddress() constant returns(address) {
        return block.coinbase;
    }

    // get current block difficulty
    function getCurrentDifficulty() constant returns(uint) {
        return block.difficulty;
    }

    // the most gas that can be spent on any given transaction right now
    function getCurrentGasLimit() constant returns(uint) {
        return block.gaslimit;
    }

    // get current block number
    function getCurrentBlockNumber() constant returns(uint) {
        return block.number;
    }

    // returns current block timestamp in seconds (not ms) from epoch
    function getBlockTimestamp() constant returns(uint) {
        return block.timestamp; // also "now" == "block.timestamp", as in "return now;"
    }

    // The data of a call to this function. Always returns "0xc8e7ca2e" for me.
    function getMsgData() constant returns(bytes) {
        return msg.data;    // adding an input parameter would probably change it with each diff call?
    }

    // Returns the address of whomever made this call 
    function getMsgSender() constant returns(address) {
        return msg.sender;  // (i.e. not necessarily the creator of the contract)
    }

    // returns amount of wei sent with this call
    function getMsgValue() constant returns(uint) {
        return msg.value;
    }

    
}