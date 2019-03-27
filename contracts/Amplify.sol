pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/BasicToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/token/ERC20/StandardBurnableToken.sol";

contract Amplify is StandardBurnableToken, Ownable {
    string public constant name = "Amplify";
    string public constant symbol = "AMPX";
    uint8 public constant decimals = 18;
    bool public crowdsaleActive = true;

    // 1.2 billion tokens * decimal places (10^18)
    uint256 public constant INITIAL_SUPPLY = 1200000000000000000000000000;

    constructor() public {
        totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        emit Transfer(address(0), msg.sender, INITIAL_SUPPLY);
    }

    modifier afterCrowdsale {
        require(
            msg.sender == owner || !crowdsaleActive,
              "Transfers are not allowed until after the crowdsale."
        );
        _;
    }

    function endCrowdsale() public onlyOwner {
        crowdsaleActive = false;
    }

    function transfer(address _to, uint256 _value) public afterCrowdsale returns (bool) {
        return BasicToken.transfer(_to, _value);
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        require(_value == 0 || allowed[msg.sender][_spender] == 0, "Use increaseApproval or decreaseApproval to prevent double-spend.");

        return StandardToken.approve(_spender, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public afterCrowdsale returns (bool) {
        return StandardToken.transferFrom(_from, _to, _value);
    }
}
