// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.19; 

import {Strings} from "../node_modules/@openzeppelin/contracts/utils/Strings.sol";
import {IERC721} from "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {Counters} from "libraries/Counters.sol";


contract NFTCardCotract {

    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    string private name;
    string private symbol;
    address public ownerOfThisContract;
    uint256 public minimumPrice = 10000000000000000;

    mapping (address owner => uint256) public _balances;
    mapping(uint256 tokenId => address) public _owners;
    mapping (uint256 tokenId => Card) public _cards;
    mapping (address => mapping(uint256 => uint256)) private _ownedTokens;

    constructor(string memory name_, string memory symbol_) {
        name = name_;
        symbol = symbol_;
        ownerOfThisContract = msg.sender;
    }

    enum Rarity {general, rare, legendary}

    struct Card {
        string name;
        string description;
        Rarity rarity;
        string imageURI;
        uint256 tokenId;
        uint256 price;
        bool onSale;
    }

    function _ownerOf(uint256 _tokenId) public view returns (address) {
        return _owners[_tokenId];
    }

    function mint(string memory _name, string memory _description, Rarity _rarity, string memory _imageURI) public  onlyOwnerOfTheContract  {
        _tokenIdCounter.increment();

        Card memory newCard = Card({
            name: _name,
            description: _description,
            rarity: _rarity,
            imageURI: _imageURI,
            tokenId: _tokenIdCounter.current(),
            price: 0,
            onSale: false
        });

        _cards[newCard.tokenId] = newCard;
        _owners[newCard.tokenId] = msg.sender;
        _balances[msg.sender] +=1 ;

        emit CardMinted(msg.sender, newCard.tokenId);

    }

    function changeCardRarity(uint256 _tokenId, Rarity _rarity) public {
        require(_owners[_tokenId] == msg.sender, "Not the owner");

        _cards[_tokenId].rarity = _rarity;
    }

    function transferFrom(address from, address to, uint256 _tokenId) public {
        _transfer(from, to, _tokenId);
    }

    function _transfer(address from, address to, uint256 _tokenId) internal {
        require(_owners[_tokenId] == from, "Not the owner");
        require(_owners[_tokenId] != to, "You cannot transfer to the same account");

        _owners[_tokenId] = to;
        _updateTokenBalances(from, to, _tokenId);

        emit Transfer(from, to, _tokenId);
    }

    function _updateTokenBalances(address from, address to, uint256 _tokenId) internal {
        if (to != address(0)) {
            _balances[to] += 1;
        }
        if (from != address(0)) {
            _balances[from] -= 1;
        }
    }

    function buyCard(address to, uint256 _tokenId) public payable {
        require(msg.value >= minimumPrice, "Not the minimum price");
        require(_cards[_tokenId].onSale == true, "Card is not on sale");
        require(_owners[_tokenId] != msg.sender && _owners[_tokenId] != to, "It is the minter");

        address from = _ownerOf(_tokenId);

        _transfer(from, to, _tokenId);
        _refundIfOverpaid(_cards[_tokenId].price);

        emit CardPurchased(from, to, _tokenId);
    }

    function _refundIfOverpaid(uint256 price) internal {
        if (msg.value > price) {
            payable(msg.sender).transfer(msg.value - price);
        }
    } 

    function setMinimumPrice(uint256 newPrice) public onlyOwnerOfTheContract {
        minimumPrice = newPrice;
    }

    function balanceOf(address owner) public view  returns (uint256 balance) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view  returns (address owner) {
        owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
    }
    

    function burn(uint256 _tokenId) public  {
        require(_owners[_tokenId] == msg.sender, "Not the owner");
        transferFrom(address(0), address(0), _tokenId);
        delete _cards[_tokenId];
        _balances[msg.sender] -= 1;

        emit Burnt(_tokenId);
    }

    

    function setCardForSale(uint256 _tokenId) public {
        require(_owners[_tokenId] == msg.sender, "Not the owner");
        _cards[_tokenId].onSale = true;

        emit CardListedForSale(msg.sender, _tokenId);
    }

    function setCardPrice(uint256 _tokenId, uint256 _price) public {
        require(_owners[_tokenId] == msg.sender, "Not the owner");
        require(_cards[_tokenId].onSale == true, "Card is not on sale");
        require(_price >= minimumPrice, "Not the minimum price ");
        
        _cards[_tokenId].price = _price;

        emit CardPriceSet(msg.sender, _tokenId);
    }

    function removeCardFromSale(uint256 _tokenId) public {
        require( _owners[_tokenId] == msg.sender, "Not the owner");
        require(_cards[_tokenId].onSale == true, "Card is not on sale");

        _cards[_tokenId].onSale = false;

        emit CardRemovedFromSale(msg.sender, _tokenId);
    }

    modifier onlyOwnerOfTheContract {
        require(msg.sender == ownerOfThisContract, "Not the contract owner");
        _;
    }

    event CardMinted (address indexed minter, uint256 indexed _tokenId);
    event CardPurchased (address indexed seller, address indexed buyer, uint256 indexed _tokenId);
    event CardListedForSale (address indexed lister, uint256 indexed _tokenId);
    event CardPriceSet (address indexed setter, uint256 indexed _tokenId);
    event CardRemovedFromSale (address indexed remover, uint256 indexed _tokenId);
    event Transfer(address indexed from, address indexed to, uint256 indexed _tokenId);
    event Burnt(uint256 indexed _tokenId);
    
}