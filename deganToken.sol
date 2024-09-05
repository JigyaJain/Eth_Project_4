// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract degenToken is ERC20{
    address private owner;
    mapping (address => uint) private bal;
    
    struct Reward {
        string name;
        uint cost; // Cost in tokens
    }

    Reward[] private rewards;   
        // Predefined rewards  
    
    struct Inventory {
        string name;
        uint cost; // Cost in tokens
        address account;
    }

    Inventory[] private inventory;   
        // Predefined rewards 

    constructor() ERC20( "Degen", "DGN"){
        owner = msg.sender;
        rewards.push(Reward("Sword", 1000));
        rewards.push(Reward("Shield", 3000));
        rewards.push(Reward("Health Potion", 2500));           
    }

    function aaA_mintToken( address _to, uint _amount) public returns (address) {  
        require ( owner == msg.sender, "Only contract owner can mint tokens");
        _mint(_to, _amount);
        bal[_to] = _amount;
        return _to;
    }

    function aaB_transferToken( address _to, uint _amount) public returns (uint, uint)  {
        
       require( bal[msg.sender]>= _amount, "Low Balance");
        _transfer(msg.sender, _to, _amount);

        bal[msg.sender] -= _amount;
        bal[_to] += _amount;

        return (bal[msg.sender], bal[_to]);

    }

    // Function to redeem reward
    function aaC_redeem(uint _rewardId) external returns (uint, string memory){
        require(_rewardId < rewards.length, "Invalid reward ID");
        Reward memory reward = rewards[_rewardId];
        require(bal[msg.sender] >= reward.cost, "Insufficient balance to redeem this reward");

        // Burn the tokens
        _burn(msg.sender, reward.cost);
        bal[msg.sender] -= reward.cost;

        address acc = msg.sender;

        inventory.push(Inventory(reward.name,reward.cost,acc));

        return (bal[msg.sender], "redeemed");
    }

    function aaD_burnToken(uint _amount) external {
        require (bal[msg.sender] >= _amount, "You should burn some less token");
        _burn(msg.sender, _amount);
    }

    function aaE_getInventory()external view returns(Inventory[] memory)
    {
        return inventory;
    }

    function aaE_getRewards()external view returns(Reward[] memory)
    {
        return rewards;
    }
}
