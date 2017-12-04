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

