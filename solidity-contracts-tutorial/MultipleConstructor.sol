// Testing multiple constructors in solidity

contract MultipleConstructor {

    address creator;
    bool first = false;
    bool second = false;

    function MultipleConstructor() {
        creator = msg.sender;
        first = true;
    }

    /* Having two constructors with same number of arguments (zero) doesn't work. Won't compile.
    function MultipleConstructor() private {
        second = true;
    }*/

    /*  Merely setting the second to private doesn't work. Won't compile.
    function MultipleConstructor() private {
        second true;
    }*/

    /*  Returning a value won't do it, either. Won't compile.
    function MultipleConstructor() returns(bool) {
        second = true;
    }*/

    /*  Adding a parameter doesn't work. Won't compile.
    function MultipleConstructor(bool irrelevantValue) {
        second = true;
    }*/

    function getFirst() constant returns(bool) {
        return first;
    }

    function getSecond() constant returns(bool) {
        return second;
    }

    // kill contract to recover funds
    function kill() {
        if (msg.sender == creator) {
            suicide(creator);
        }
    }
}