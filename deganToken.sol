// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract degenToken is ERC20{
    address private owner;
    mapping (address => uint) public bal;
    
    struct Reward {
        string name;
        uint cost; // Cost in tokens
    }

    Reward[] public rewards;   
        // Predefined rewards  

    constructor() ERC20( "Degen", "DGN"){
        owner = msg.sender;
        rewards.push(Reward("Sword", 1000));
        rewards.push(Reward("Shield", 3000));
        rewards.push(Reward("Health Potion", 2500));           
    }

    function mintToken( address _to, uint _amount) public returns (address) {  
        require ( owner == msg.sender, "Only contract owner can mint tokens");
        _mint(_to, _amount);
        bal[_to] = _amount;
        return _to;
    }

    function transferToken(address _from, address _to, uint _amount) public returns (uint, uint)  {
        
       require( bal[_from]>= _amount, "Low Balance");
        _transfer(_from, _to, _amount);

        bal[_from] -= _amount;
        bal[_to] += _amount;

        return (bal[_from], bal[_to]);

    }

    // Function to redeem reward
    function redeem(address _add, uint _rewardId) external returns (uint, string memory){
        require(_rewardId < rewards.length, "Invalid reward ID");
        Reward memory reward = rewards[_rewardId];
        require(bal[_add] >= reward.cost, "Insufficient balance to redeem this reward");

        // Burn the tokens
        _burn(_add, reward.cost);
        bal[_add] -= reward.cost;

        return (bal[_add], "redeemed");
    }

    function burnToken( address _add, uint _amount) external {
        require (bal[_add] >= _amount, "You should burn some less token");
        _burn(_add, _amount);
    }

}


/*
0xFae9148E6458787B5737686F98A1E3161f8dEcb2
0xD57Cc0AD0c3ff4D5a13bf3fDe9Ab9624f4A282db
*/
