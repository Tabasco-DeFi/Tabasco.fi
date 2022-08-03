// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "../interfaces/ITabascoERC20.sol";
import "../utils/SafeMath.sol";

contract TabascoERC20 is ITabascoERC20 {
    using SafeMath for uint256;

    mapping(address => uint256) private _balanceOf;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string public constant _name = "Tabasco V1.0";
    string public constant _symbol = "TSHOT";

    // EIP712
    bytes32 public DOMAIN_SEPARATOR;

    constructor() {
        uint256 chainId;
        assembly {
            chainId := chainId
        }

        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'),
                keccak256(bytes(_name)),
                keccak256(bytes('1')),
                chainId,
                address(this)
            )
        );
    }
    
    function name() external pure returns (string memory) {
        return _name;
    }

    function symbol() external pure returns (string memory){
        return _symbol;
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }

    function totalSupply() external view returns (uint256){
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256){
        return _balanceOf[account];
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return _allowances[owner][spender];
    }
    function approve(address spender, uint256 amount) external returns (bool){
        address owner = msg.sender;
        _approve(owner, spender, amount);
        return true;
    }

    function _approve(address _owner, address _spender, uint256 _amount) private {
        require(_owner != address(0), "[TabascoERC20]: Approval from address(0)");
        require(_spender != address(0), "[TabascoERC20]: Approval from address(0)");
        _allowances[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }

    function transfer(address recipient, uint256 amount) external returns (bool){
        require(msg.sender != address(0), "[TabascoERC20] Null address");
        require(recipient != address(0), "[TabascoERC20] Null address");
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function _transfer(address from, address to, uint256 value) private returns (bool) {
        _balanceOf[from] = _balanceOf[from].sub(value);
        _balanceOf[to] = _balanceOf[to].add(value);
        return true;
    }
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        // have to check underflow uint(-1) == type(uint256).max
        if(_allowances[sender][msg.sender] > type(uint256).min && _allowances[sender][msg.sender] >= amount){
            _allowances[sender][msg.sender] = _allowances[sender][msg.sender].sub(amount);
        }
        _transfer(sender, recipient, amount);
        return true;
    }

    //// @notice: Transfer an (underlying)asset into the protocol
    function mint() external returns (bool) {}
    
    function _mint() private {}

    function burn() external returns (bool) {}

    function _burn() private {}

    function borrow() external returns (bool) {}

    function _borrow() private {}

}