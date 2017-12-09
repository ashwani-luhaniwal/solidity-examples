// Examination of msgs

pragma solidity ^0.4.0;

contract MsgExaminer {

    address creator;
    address miner;

    bytes contract_creation_data;
    uint contract_creation_gas;
    uint contract_creation_value;
    uint contract_creation_tx_gasprice;
    address contract_creation_tx_origin;

    function MsgExaminer() public {
        creator = msg.sender;

        miner = 0x910561dc5921131ee5de1e9748976a4b9c8c1e80;
        contract_creation_data = msg.data;
        contract_creation_gas = msg.gas;
        contract_creation_value = msg.value;    // the endowment of this contract in wei

        contract_creation_tx_gasprice = tx.gasprice;
        contract_creation_tx_origin = tx.origin;
    }

    function getContractCreationData() constant returns(bytes) {
        return contract_creation_data;
    }

    function getContractCreationGas() constant returns(uint) {
        // Must be the gas expended
        // the creation of this contract. msg.gas should be msg.gasExpended
        return contract_creation_gas;
    }

    // returns the original endowment of the contract 
    function getContractCreationValue() constant returns(uint) {
        // set at creation time with "value: <someweivalue>"
        // this is now the "balance" of the contract
        return contract_creation_value;
    }

    // It is gasprice
    function getContractCreationTxGasprice() constant returns (uint) {
        // the sender is willing to pay. msg.gasPrice should be msg.gasLimit
        return contract_creation_tx_gasprice;
    }

    // returned my coinbase address
    function getContractCreationTxOrigin() constant returns(address) {
        // Not sure if a chain of transactions would return the same.
        return contract_creation_tx_origin;
    }

    bytes msg_data_before_creator_send;
    bytes msg_data_after_creator_send;
    uint msg_gas_before_creator_send;
    uint msg_gas_after_creator_send;
    uint msg_value_before_creator_send;
    uint msg_value_after_creator_send;

    function sendOneEtherToMiner() returns(bool success) {
        // save msg values 
        msg_gas_before_creator_send = msg.gas;
        msg_data_before_creator_send = msg.data;
        msg_value_before_creator_send = msg.value;
        bool returnval = miner.send(1000000000000000000);
        msg_gas_after_creator_send = msg.gas;
        msg_data_after_creator_send = msg.data;
        msg_value_after_creator_send = msg.value;
        return returnval;
    }

    function sendOneEtherToHome() returns(bool success) {
        msg_gas_before_creator_send = msg.gas;
        msg_data_before_creator_send = msg.data;
        msg_value_before_creator_send = msg.value;
        bool returnval = creator.send(1000000000000000000);
        msg_gas_after_creator_send = msg.gas;
        msg_data_after_creator_send = msg.data;
        msg_value_after_creator_send = msg.value;
        return returnval;
    }

    function getMsgDataBefore() constant returns(bytes) {
        return msg_data_before_creator_send;
    }

    function getMsgDataAfter() constant returns(bytes) {
        return msg_data_after_creator_send;
    }

    function getMsgGasBefore() constant returns(uint) {
        return msg_gas_before_creator_send;
    }

    function getMsgGasAfter() constant returns(uint) {
        return msg_gas_after_creator_send;
    }

    function getMsgValueBefore() constant returns(uint) {
        return msg_value_before_creator_send;
    }

    function getMsgValueAfter() constant returns(uint) {
        return msg_value_after_creator_send;
    }

    // kill to recover funds
    function kill() {
        if (msg.sender == creator) {
            suicide(creator);
        }
    }
 }