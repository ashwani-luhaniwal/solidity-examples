/*
    This is a demonstration of the various global variables available to contracts.
*/

pragma solidity ^0.4.0;

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

    /** A note about gas and gasprice:
        Every transaction must specify a quanity of "gas" that it is willing to consume (called startgas),
        and the fee that it is willing to pay per unit gas (gasprice). At the start of execution,
        startgas * gasprice ether are removed from the transaction sender's account.
        Whatever is not used is immediately refunded.
    */

    // get information about remaining gas
    function getMsgGas() constant returns(uint) {
        return msg.gas;
    }

    // "gasprice" is the amount of gas the sender was *willing* to pay. 50000000 for me. (geth default)
    function getTxGasprice() constant returns(uint) {
        return tx.gasprice;
    }

    // returns sender of the transaction
    function getTxOrigin() constant returns(address) {
        // What if there is a chain of calls? I think it returns the first sender, whoever provided the gas.
        return tx.origin;
    }

    // returns contract address
    function getContractAddress() constant returns(address) {
        return this;
    }

    // returns current balance of contract
    function getContractBalance() constant returns(uint) {
        return this.balance;
    }

    // kill to recover funds
    function kill() {
        if (msg.sender == creator) {
            suicide(creator);   // kills this contract and sends remaining funds back to creator
        }
    }
}

/*
var abi = [{
    "constant": true,
    "inputs": [],
    "name": "getContractAddress",
    "outputs": [{
        "name": "",
        "type": "address"
    }],
    "type": "function"
}, {
    "constant": false,
    "inputs": [],
    "name": "kill",
    "outputs": [{
        "name": "",
        "type": "bool"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getContractBalance",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getCurrentBlockNumber",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getTxGasprice",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getBlockTimestamp",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getMsgSender",
    "outputs": [{
        "name": "",
        "type": "address"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getCurrentGasLimit",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getMsgGas",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getCurrentDifficulty",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getMsgValue",
    "outputs": [{
        "name": "",
        "type": "uint256"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getTxOrigin",
    "outputs": [{
        "name": "",
        "type": "address"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getMsgData",
    "outputs": [{
        "name": "",
        "type": "bytes"
    }],
    "type": "function"
}, {
    "constant": true,
    "inputs": [],
    "name": "getCurrentMinerAddress",
    "outputs": [{
        "name": "",
        "type": "address"
    }],
    "type": "function"
}, {
    "input": [],
    "type": "constructor"
}];
*/