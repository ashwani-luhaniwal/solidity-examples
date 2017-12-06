// *** EXAMPLE: A crowdfunding example (broadly similar to Kickstarter) ***
// ** START EXAMPLE **

// CrowdFunder.sol

/// @title CrowdFunder 
/// @author Ashwani K Luhaniwal
contract CrowdFunder {
    // Variables set on create by creator
    address public creator;
    address public fundRecipient;   // creator may be different than recipient 
    uint public minimumToRaise;     // required to tip, else everyone gets refund 
    string campaignUrl;
    byte constant version = 1;

    // Data structures
    enum State {
        Fundraising,
        ExpiredRefund,
        Successful
    }
    struct Contribution {
        uint amount;
        address contributor;
    }

    // State variables 
    State public state = State.Fundraising; // initialize on create
    uint public totalRaised;
    uint public raiseBy;
    uint public completeAt;
    Contribution[] contributions;

    // event declaration
    event LogFundingReceived(address addr, uint amount, uint currentTotal);
    event LogWinnerPaid(address winnerAddress);

    // modifier definition
    modifier inState(State _state) {
        if (state != _state) throw;
        _;
    }
    modifier isCreator() {
        if (msg.sender != creator) throw;
        _;
    }

    // Wait 6 months after final contract state before allowing contract destruction
    modifier atEndOfLifecycle() {
        if ( !((state == State.ExpiredRefund || state == State.Successful) && completeAt + 6 months < now) ) {
            throw;
        }
        _;
    }

    // constructor
    function CrowdFunder(
        uint timeInHoursForFundraising,
        string _campaignUrl,
        address _fundRecipient,
        uint _minimumToRaise) 
    {
        creator = msg.sender;
        fundRecipient = _fundRecipient;
        campaignUrl = _campaignUrl;
        minimumToRaise = _minimumToRaise;
        raiseBy = now + (timeInHoursForFundraising * 1 hours);
    }

    function contribute() public inState(State.Fundraising) {
        contributions.push (
            Contribution({
                amount: msg.value,
                contributor: msg.sender
            })  // use array, so can iterate
        );
        totalRaised += msg.value;

        LogFundingReceived(msg.sender, msg.value, totalRaised);

        checkIfFundingCompleteOrExpired();
        return contributions.length - 1;    // return id 
    }

    function checkIfFundingCompleteOrExpired() {
        if (totalRaised > minimumToRaise) {
            state = State.Successful;
            payOut();

            // could incentivize sender who initiated state change here
        }
        else if (now > raiseBy) {
            state = State.ExpiredRefund;    // backers can now collect refunds by calling getRefund(id)
        }
        completeAt = now;
    }

    function payOut() public inState(State.Successful) {
        if (!fundRecipient.send(this.balance)) {
            throw;
        }

        LogWinnerPaid(fundRecipient);
    }

    function getRefund(id) public inState(State.ExpiredRefund) {
        if (contributions.length <= id || id < 0 || contributions[id].amount == 0) {
            throw;
        }

        uint amountToRefund = contributions[id].amount;
        contributions[id].amount = 0;

        if (!contributions[id].contributor.send(amountToSend)) {
            contributions[id].amount = amountToSend;
            return false;
        }

        return true;
    }

    function removeContract() public isCreator() atEndOfLifecycle() {
        selfdestruct(msg.sender);
        // creator gets all money that hasn't be claimed
    }

    function() {
        throw;
    }
}
// ** END EXAMPLE **