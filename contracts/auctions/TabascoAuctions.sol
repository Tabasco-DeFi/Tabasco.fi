// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "../interfaces/IERC20.sol";
import {Actions} from "../libs/Actions.sol";
import {Products} from "../libs/Options.sol";

contract AuctionManager {
    using Products for Products.Option;
    IERC20 public usdc;

    /************************************
    ************** State ****************
    ************************************/
    // NOTE! TBD 
    address internal auctionManager;
    bool public auctionDidStart = false;
    
    Products.Option[] public requstedOptions;
    mapping(uint256 => Products.Option) public options;
    mapping(address => bool) public requestedOptionPurchase;

    constructor(address _usdc){
        auctionManager = msg.sender;
        usdc = IERC20(_usdc);
    }

    //// @notice: Status of the current Auction. 
    //// NOTE! IsOpening, IsClosing => Preparation time
    enum AucitonState {
        IsOpening,
        Open,
        IsClosing,
        Closed
    }

    /************************************
    ************* Modifier **************
    ************************************/

    modifier requestedOwner() {
        require(requestedOptionPurchase[msg.sender], "User has not requested to purchase/sell an Option");
        _;
    }

    modifier acceptedOwner() {
        require(acceptedOptionPurhcase[msg.sender], "Market maker has not acception to purchase/sell an option");
        _;
    }

    /************************************
    ************** Events ***************
    ************************************/

    //// @notice: Event triggered when user request to buy/sell an option
    event UserRequestOption(address userAddress, uint256 optionId, uint256 requestAmount, Actions.UserOptionActionType actionType);

    //// @notice: Event triggered when user cancel buy/sell an option that he/she previously requested
    event UserCancelOption(address userAddress, uint256 optionId, Actions.UserOptionActionType actionType);

    //// @notice: Event triggered when a Market Maker accepts to buy/sell an option from user
    event MakerAcceptBuyOption(uint256 optionId, Action.UserOptionActionType actionType);

    //// @notice: Event triggered when a Market Maker decides to cancel the option that he/she previously accepted
    event MakerCacelOption(uint256 optionId, Action.UserOptionActionType actionType);


    /************************************
    *********** Pre-Auction *************
    ************************************/

    function requestBuyOption(uint256 _optionId, uint256 _purchaseAmount) external {
        // Check user's USDC balance and check if user has enough balance in his account
        require(usdc.balanceOf(msg.sender)>= _purchaseAmount, "Not enough balance to deposit");
        require(msg.sender != address(0), "Invalid user address");

        // transfer USDC to current contract
        usdc.transferFrom(msg.sender, address(this), _purchaseAmount);

        // approve current contract to transfer the stablecoin when contract is confirmed
        usdc.approve(address(this), _purchaseAmount);

        // Create optionId?

    }
    
    function requestSellOption() external {}
    function cancelBuyOption() external requestedOwner {
    }
    function cancelSellOption() external requestedOwner {}


    /************************************
    *********** Post-Auction ************
    ************************************/
    function acceptBuyOption() external {}
    function acceptSellOption() external {}
    function cancelRequestBuy() external {}
    function cancelRequestSell() external {}

    function startAuction() external {}
    function closeAuction() external {}


    /************************************
    ************* Options ***************
    ************************************/
    function _createOption() internal {}




}

/*
* 1. time =>  block.timestamp(x) block.number(o)
* 2. option premium => data from market
* 3. Manage all auction in single contract? Yes
* 4. How to start auciton
*/