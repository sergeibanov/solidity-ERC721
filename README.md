## Features

- **ERC-721 NFT Contract**: Implements a Solidity smart contract for issuing and managing collectible cards as NFTs using the ERC-721 token standard.
- **Standards Compliance**: Ensures adherence to the ERC-721 specification, supporting secure and transparent token operations.
- **Comprehensive Functionality**: Includes features for minting, selling, and managing NFT collectible cards.

## Getting Started

1. Clone the repository.
2. Open the project in your preferred development environment.
3. Compile the smart contracts using tools like Remix or Foundry.
4. Deploy the contracts to an Ethereum testnet of your choice (e.g., Sepolia, Goerli).
5. Interact with the deployed contracts via a suitable frontend or directly using Web3.js.

## ERC-721 Contract Overview

This repository includes a smart contract implementing the ERC-721 standard for NFT collectible cards. Below are the contract's key functionalities:

### Features

- **Data Structure (Card)**:
  - `name`: Name of the card.
  - `description`: Description of the card.
  - `rarity`: Rarity category (e.g., common, rare, legendary).
  - `imageURI`: Link to the card image.

- **Core Functions**:
  - `mint(string memory _name, string memory _description, string memory _rarity, string memory _imageURI)`: Creates and issues a new collectible card as an NFT.
  - `buyCard(uint256 _tokenId, uint256 _price)`: Allows users to purchase a listed card at the specified price.
  - `setCardForSale(uint256 _tokenId, uint256 _price)`: Lists a card for sale at a given price.
  - `removeCardFromSale(uint256 _tokenId)`: Removes a card from the sale list.
  - `transfer(address _to, uint256 _tokenId)`: Transfers a card to another address using ERC-721's standard transfer functionality.

- **Events**:
  - `CardMinted`: Triggered when a new card is created.
  - `CardPurchased`: Triggered when a card is purchased.
  - `CardListedForSale`: Triggered when a card is listed for sale.
  - `CardRemovedFromSale`: Triggered when a card is removed from sale.

- **Optional Features**:
  - `changeCardRarity(uint256 _tokenId, string memory _newRarity)`: Allows the contract owner to update the rarity of a card.
  - `burn(uint256 _tokenId)`: Destroys a card, removing it from the supply.

- **Initialization**:
  - Cards are minted with unique properties and made available for transfer or sale.

- **Security**:
  - Implements robust mechanisms to handle edge cases, such as invalid operations or unauthorized actions.

- **Testing**:
  - The contract has been thoroughly tested in an Ethereum development environment to ensure compliance and reliability.

## Contributions

Contributions to this project are welcome. Feel free to open issues or submit pull requests.

## License

This project is licensed under the [MIT License](LICENSE).
