## ERC-721 Contract Overview

This particular repo is the result of the forth task assigned by Chat GPT. I provided the whole idea of the "Solidity Chat GPT Test Tasks Project" in this repo. Feel free to read it. Below is the task description provided by Chat GPT:

## Task Description

**Title**: Development of a Smart Contract for Issuing and Managing NFT Collectible Cards

**Objective**: To create a Solidity smart contract for issuing, selling, and managing collectible cards as NFTs, incorporating ERC721 standards and smart contract functionality.

**Requirements**:

- **Data Structure (Card)**:
  - `name` (name of the card)
  - `description` (description of the card)
  - `rarity` (rarity of the card: common, rare, legendary, etc.)
  - `imageURI` (link to the card image)

- **Functions**:
  - `mint(string memory _name, string memory _description, string memory _rarity, string memory _imageURI)` - creates and issues a new card to the contract owner.
  - `buyCard(uint256 _tokenId, uint256 _price)` - allows a user to buy a card at the specified price.
  - `setCardForSale(uint256 _tokenId, uint256 _price)` - sets a card for sale at a certain price.
  - `removeCardFromSale(uint256 _tokenId)` - removes a card from sale.
  - `transfer(address _to, uint256 _tokenId)` - transfers a card to another address (note that ERC721 already provides standard functions for transfer).

- **Events**:
  - `CardMinted` - a card is created.
  - `CardPurchased` - a card is purchased.
  - `CardListedForSale` - a card is listed for sale.
  - `CardRemovedFromSale` - a card is removed from sale.

- **Additional Features (Optional)**:
  - `changeCardRarity(uint256 _tokenId, string memory _newRarity)` - allows the contract owner to change the rarity of a card.
  - `burn(uint256 _tokenId)` - destroys a card.

**Evaluation Criteria**:
- Correct implementation of functions and data structures.
- Adherence to the ERC721 standard.
- Cleanliness and readability of the code.
- Proper handling of exceptional situations.
- Implementation of additional features.
