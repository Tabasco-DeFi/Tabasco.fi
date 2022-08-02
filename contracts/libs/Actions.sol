// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

library Actions {
    enum ActionType {
        Lend,
        Borrow,
        Repay,
        Redeem,
        Transfer
    }

    enum OptionActionType {
        BuyOption,
        SellOption,
        RedeemOptionReward,
        ReRollOption
    }

    struct ActionArgs {
        ////@notice: Type of action to execute
        ActionType actionType;
        ////@notice: Address of the account owner or message sender
        address sender;
        ////@notice: Asset that is to be transferred
        address asset;
        ////@notice: Type of pool to withdraw/deposit from/to
        uint256 poolId;
        ////@notice: Number of assets to [Lend|Borrow|Repay|Redeem|Transfer]
        uint256 amount;
    }

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
        ////@notice: Check option has been exercised
        bool exercised;
        ////@notice: Address of the borrower
        address borrowerAddress;
    }

}