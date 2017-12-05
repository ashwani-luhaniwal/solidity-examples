// We will be discussing the basics of Solidity

// 1. DATA TYPES AND ASSOCIATED METHODS
// uint used for currency amount (there are no doubles
// or floats) and for dates (in unix time)
uint x;

// int of 256 bits, cannot be changes after instantiation
int constant a = 8;
int256 constant a = 8;  // same effect as line above, here the 256 is explicit
uint constant VERSION_ID = 0x123A1; // A hex constant
// with 'constant', compiler replaces each occurrence with actual value

// For int and uint, can explicitly set space in steps of 8 up to 256
// e.g., int8, int16, int24
uint8 b;
int64 c;
uint248 e;

// Be careful that don't overflow, and protect against attacks that do 

// No random functions built in, use other contracts for randomness

// Type casting
int x = int(b);

bool b = true;  // or do 'var b = true;' for inferred typing

// Addresses - holds 20 byte/160 bit Ethereum addresses 
// No arithmetic allowed
address public owner;

// Types of accounts:
// Contract account: address set on create (func of creator address, num transactions sent)
// External Account: (person/external entity): address created from public key

// Add 'public' field to indicate publicly/externally accessible
// a getter is automatically created, but NOT a setter

// All addresses can be sent ether 
owner.send(SOME_BALANCE);   // returns false on failure
if (owner.send) { } // REMEMBER: wrap in 'if', as contract addresses have
// functions executed on send and these can fail 
// Also, make sure to deduct balances BEFORE attempting a send, as there is a risk of a recursive
// call that can drain the contract

// can override send by defining your own 

// Can check balance 
owner.balance;  // the balance of the owner (user or contract)

// Bytes available from 1 to 32
byte a; // byte is same as bytes1
bytes2 b;
bytes32 c;

// Dynamically sized bytes 
bytes m;    // A special array, same as byte[] array (but packed tightly)
// More expensive than byte1-byte32, so use those when possible

// same as bytes, but does not allow length or index access (for now)
string n = "hello"; // stored in UTF8, note double quotes, not single
// string utility functions to be added in future
// prefer bytes32/bytes, as UTF8 uses more storage

// Type inference
// var does inferred typing based on first assignment,
// can't be used in functions parameters
var a = true;
// use carefully, inference may provide wrong type 
// e.g., an int8, when a counter needs to be int16 

// var can be used to assign function to variable
function a(uint x) returns (uint) {
    return x * 2;
}
var f = a;
f(22);  // call

// by default, all values are set to 0 on instantiation 

// Delete can be called on most types 
// (does NOT destroy value, but sets value to 0, the initial value)
uint x = 5;

// Destructuring/Tuples
(x, y) = (2, 7);    // assign/swap multiple value 

// 2. DATA STRUCTURES
// Arrays
bytes32[5] nicknames;   // static array 
bytes32[] names;        // dynamic array
uint newLength = names.push("John");    // adding returns new length of the array
// Length 
names.length;   // get length 
names.length = 1;   // lengths can be set (for dynamic arrays in storage only)

// multidimensional array 
uint x[][5];    // arr with 5 dynamic array elements (opp order of most languages)

// Dictionaries (any type to any other type)
mapping (string => uint) public balances;
balances["charles"] = 1;
console.log(balances["ada"]);   // is 0, all non-set key values return zeroes
// 'public' allows following from another contract
contractName.balances("charles");   // returns 1
// 'public' created a getter (but not setter) like the following:
function balances(string _account) returns (uint balance) {
    return balances[_account];
}

// Nested mappings
mapping (address => mapping (address => uint)) public custodians;

// To delete
delete balances["John"];
delete balances;    // sets all elements to 0

// Unlike other languages, CANNOT iterate through all elements in
// mapping, without knowing source keys - can build data structure 
// on top to do this

// Structs and enums
struct Bank {
    address owner;
    uint balance;
}
Bank b = Bank({
    owner: msg.sender,
    balance: 5
});
// or
Bank c = Bank(msg.sender, 5);

c.balance = 5;  // set to new value
delete b;
// sets to initial value, set all variables in struct to 0, except mappings 

// Enums 
enum State { Created, Locked, Inactive };   // often used for state machine 
State public state; // Declare variable from enum 
state = State.Created;
// enums can be explicitly converted to ints 
uint createdState = uint(State.Created);    // 0

// Data locations: Memory vs. storage vs. stack - all complex types (arrays,
// structs) have a data location 
// 'memory' does not persist, 'storage' does 
// Default is 'storage' for local and state variables; 'memory' for func params 
// stack holds small local variables 

// for most types. can explicitly set which data location to use 

// 3. Simple operators
// Comparison, bit operators and arithmetic operators are provided
// exponentiation: **
// exclusive or: ^
// bitwise negation: ~

// 4. Global Variables of note 
// ** this **
this;   // address of contract
// often used at end of contract life to send remaining balance to party
this.balance;
this.someFunction();    // calls func externally via call, not via internal jump

// ** msg - Current message received by the contract ** **
msg.sender; // address of sender 
msg.value;  // amount of ether provided to this contract in wei 
msg.data    // bytes, complete call data 
msg.gas     // remaining gas 

// ** tx - This transaction **
tx.origin;  // address of sender of the transaction
tx.gasprice;    // gas price of the transaction

// ** block - Information about current block **
now;        // current time (approximately), alias for block.timestamp (uses Unix time)
block.number;   // current block number
block.difficulty;   // current block difficulty
block.blockhash(1); // returns bytes32, only works for most recent 256 blocks 
block.gasLimit();

// ** storage - Persistent storage hash **
storage['abc'] = 'def'; // maps 256 bit words to 256 bit words

// 4. FUNCTIONS AND MORE 
// A. Functions 
// Simple function 
function increment(uint x) returns (uint) {
    x += 1;
    return x;
}

// Functions can return many arguments, and by specifying returned arguments
// name don't need to explicitly return 
function increment(uint x, uint y) returns (uint x, uint y) {
    x += 1;
    y += 1;
}
// Call previous function 
uint (a, b) = increment(1, 1);

// 'constant' indicates that function does not/cannot change persistent vars 
// Constant function execute locally, not on blockchain
uint y;

function increment(uint x) constant returns (uint x) {
    x += 1;
    y += 1; // this line would fail
    // y is a state variable, and can't be changed in a constant function 
}