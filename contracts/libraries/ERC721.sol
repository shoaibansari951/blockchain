// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import './libraries/ERC165.sol';
// import './interfaces/IERC721.sol';
import './ERC165.sol';
import '../interfaces/IERC721.sol';

contract ERC721 is ERC165, IERC721 {

    event transfer(address indexed to, address indexed from , uint indexed id);
    event approval(address indexed owner, address indexed approved, uint indexed tokenId);

    mapping (uint => address) private _tokenOwner;
    mapping (address => uint) private _tokenOwnedCount;
    mapping (uint => address) private _tokenApprovals;
    constructor()  {
        _registedInterface(bytes4(keccak256('balanceOf(bytes4)')^
        keccak256('ownerOf(bytes4)')^
        keccak256('transferFrom(bytes4)')^
        keccak256('approve(address,bytes4)')));
    }

    function exists(uint _tokenId) internal view returns (bool) {
        address owner = _tokenOwner[_tokenId];
        return owner != address(0);
    }
    function balanceOf(address _owner) public view returns (uint balance) {
        require(_tokenOwnedCount[_owner] != 0, "Owner does not have any tokens");
        return _tokenOwnedCount[_owner];
    }
    function ownerOf(uint _tokenId) public view returns (address owner) {
        address _owner = _tokenOwner[_tokenId];
        return _owner;
    }
    function _mint(address to, uint tokenId) virtual internal {
        require(to != address(0), "to address is not allowed to be 0x0");
        require(!exists(tokenId), "tokenId already exists");
        _tokenOwner[tokenId] = to;
        _tokenOwnedCount[to]++;
        emit transfer(address(0),to, tokenId);
    }
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        require(exists(_tokenId), "tokenId does not exist");
        require(ownerOf(_tokenId) == _from, "Sender does not own this token");
        _tokenOwnedCount[_from]-=1;
        _tokenOwnedCount[_to]+=1;
        _tokenOwner[_tokenId] = _to;
        emit transfer(_from, _to, _tokenId);
    }
    function transferFrom(address _from, address _to, uint256 _tokenId) override public {
        require(isApprovedOrOwner(msg.sender, _tokenId), "Sender is not approved or owner");
        _transferFrom(_from, _to, _tokenId);
    }
    function Approve(address _to, uint tokenId) public {
        address owner = ownerOf(tokenId);
        require(_to != owner, "Only the owner can approve this token");
        require(msg.sender == owner, "Only the owner can approve this token");
        _tokenApprovals[tokenId] = _to;
        emit approval(owner, _to, tokenId);
    }
    function isApprovedOrOwner(address spender,uint _tokenId) internal view returns (bool) {
        require(exists(_tokenId), "tokenId does not exist");
        address owner = ownerOf(_tokenId);
        return (spender == owner);
    }
}