// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

library OptionActions {
        enum OptionActionType {
        BuyOption,
        SellOption,
        RedeemOptionReward,
        ReRollOption
    }

    enum OptionType {
        CALL,
        PUT
    }

    //// @dev : Includes all the option arguments that will be passed from outside
    ////@dev : Have to be discussed on whether an option reroll can be cancelled when borrower returns the borrowed amount
    struct OptionActionArgs {
        ////@notice: Type of option action to execute
        OptionActionType optionActionType;
        ////@notice: Option Stirke price
        uint256 strikePrice;
        ////@notice: Option collateral which option seller has to pay. 0 if not option seller
        uint256 optionCollateral;
        ////@notice: Amount of CALL option to purchase
        uint256 callOptionPurchaseAmount;
        ////@notice: Amount of PUT option to sell
        uint256 putOptionPurchaseAmount;
        ////@notice: Option expiration date
        uint256 expiration;
        ////@notice: How many times to reroll the option
        uint256 optionRerollCount;
        ////@notice: Check option has been exercised
        bool exercised;
        ////@notice: Address of the borrower
        address borrowerAddress;
    }

    struct BuyOptionArgs {
        ////@notice: Option type : [CALL | PUT]
        OptionType optionType;
        ////@notice: Option Stirke price
        uint256 strikePrice;
        ////@notice: Option Premium 
        uint256 optionPremium;
        ////@notice: Amount of [CALL | PUT] option to purchase
        uint256 optionBuyAmount;
        ////@notice: Option expiration date
        uint256 expiration;
        ////@notice: Check option has been exercised
        bool exercised;
        ////@notice: Address of the borrower
        address borrowerAddress;
    }

    //// @dev : TODO For future option products (TBD)
    struct SellOptionArgs {
        ////@notice: Option type : [Call | PUT]
        OptionType optionType;
        ////@notice: Option Stirke price
        uint256 strikePrice;
        ////@notice: Option collateral which option seller has to pay. 0 if not option seller
        uint256 optionCollateral;
        ////@notice: Amount of [CALL | PUT] option to sell
        uint256 optionSellAmount;
        ////@notice: Option expiration date
        uint256 expiration;
        ////@notice: Check option has been exercised
        bool exercised;
        ////@notice: Address of the borrower
        address borrowerAddress;
    }

    // struct RedeemRewardArgs {} 

    // struct RerollArgs {}

    //// @param Pass the Option arguments
    function _setBuyOptionArgs(OptionActionArgs memory _args) internal pure returns (BuyOptionArgs memory){
        require(_args.optionActionType == OptionActionType.BuyOption);
        require(_args.borrowerAddress != address(0));
    }
}