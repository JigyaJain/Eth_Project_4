# Eth_Project_4

# Degan Token (DT) ERC20 Token Deployment Using Avalanche

This Solidity Smart Contract, DeganToken, is a blockchain-based application designed to provide a secure and transparent way for users to manage their ERC20 tokens, mint new tokens, burn tokens, transfer tokens, and interact with an in-game inventory system. This README provides an overview of the contract's functionalities and instructions for setting up and using the contract.

## Description

The `dengenToken` Solidity Smart Contract serves as the backbone of a decentralized application (dApp) that allows users to interact with Ethereum blockchain features. It includes the following key functionalities:The DeganToken Solidity Smart Contract serves as the backbone of a decentralized application (dApp) that allows users to interact with blockchain features on the Avalanche network. It includes the following key functionalities:

* **Mint Tokens:** The contract owner can mint new tokens.
* **Burn Tokens:** Users can burn their tokens, reducing the total supply.
* **Transfer Tokens:** Users can transfer tokens to other Ethereum addresses.
* **Redeem Items:** Users can redeem items which are available in Rewards multiple times and they are added in the Inventory.
* **In-Game Store:** Users can burn tokens to purchase in-game items which are stored in Rewards.
* **In-Game Balance:** Users can also check their in game balance.
* The contract utilizes Solidity's features such as events, error handling with require and revert statements, and access control through owner verification. These features ensure the contract's reliability, security, and user-friendliness.

## Getting 

### Prerequisites

To use this smart contract, you need to have the following:

* A web browser with MetaMask installed
* Access to Remix IDE (https://remix.ethereum.org/)
* Access to a metamask wallet with their network on Avalanche fuji test network.

### Running the Contract on Remix IDE

1. **Open Remix IDE:**
   Go to [Remix IDE](https://remix.ethereum.org/).

2. **Create a New File:**
   Create a new file in Remix IDE and name it `dengenToken.sol`.

3. **Copy the Contract Code:**
   Copy and paste the following Solidity code into the `dengenToken.sol` file:
```
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

 ```

## Compile the Contract

1. Go to the "Solidity Compiler" tab on the left panel.
2. Select the compiler version `0.8.26`.
3. Click on the "Compile degenToken.sol" button.


## Deploy the Contract

1. Go to the "Deploy & Run Transactions" tab on the left panel.
2. Select "Injected Web3" as the environment to connect to MetaMask.
3. Make sure you are connected to the Avalanche Fuji Test network.
4. Click on the "Deploy" button next to `degenToken`.

## Interact with the Contract

1. After deploying, you will see the deployed contract under "Deployed Contracts".
2. You can interact with the contract using the available functions (e.g. aaA_mintToken, aaB_transferToken, aaC_redeem, aaD_burnToken, aaE_get_Reward, aaE_get_Inventory).
3. You will be able to see the transation on the deployed contract on snowtrace test weibsite.

## Help

If you encounter any issues or have questions about using the smart contract, please contact [preetjawla6@gmail.com].

## Authors

Jigya Jain

## License

This project is licensed under the MIT License 

