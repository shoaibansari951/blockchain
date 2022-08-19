// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721.sol';
import '../interfaces/IERC721Enumerable.sol';
 contract ERC721Enumerable is IERC721Enumerable ,ERC721  {
    
    uint[] private _alltokens;
    mapping (uint => uint) private _allTokenIndex;
    mapping (address => uint[]) private _ownedTokens;
    mapping(uint =>uint) private _ownedTokenIndex;

    constructor()  {
        _registedInterface(bytes4(keccak256('supportsInterface(bytes4)')^
        keccak256('totalSupply(bytes4)')^
        keccak256('transferFrom(bytes4)')^
        keccak256('approve(address,bytes4)')));
    }

    function tokenOfOwnerByIndex(address owner, uint index) public view returns (uint) {
        require(index < balanceOf(owner), "index out of range");
        return _ownedTokens[owner][index];
    }

    function totalSupply() public view returns (uint256){
        return _alltokens.length;
    }

    function tokenByIndex(uint index) public view returns (uint) {
        require(index < totalSupply(), "index out of bounds");
        return _alltokens[index];
    }
    
    // function tokenByIndex(uint256 _index) external view returns (uint256){
    //     return _alltokens[_index];
    // }

    // function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){
    //     uint256 tokenId = _alltokens[_index];
    //     return ownerOf(tokenId);
    // }

    function _mint(address to, uint tokenId) internal override(ERC721) {
       super._mint(to, tokenId);
       _addTokensToAllTokensEnumeration(tokenId);
    _addTokenstoOwnerEnumerations(to, tokenId);

    }

    function _addTokenstoOwnerEnumerations(address to,uint tokenId) private {
        _ownedTokens[to].push(tokenId);
        _ownedTokenIndex[tokenId] = _ownedTokens[to].length;
    }

    function _addTokensToAllTokensEnumeration(uint256 tokenId) internal {
        _allTokenIndex[tokenId] = _alltokens.length;
        _alltokens.push(tokenId);
        // _allTokenIndex[tokenId] = _alltokens.length - 1;
    }
    
 }