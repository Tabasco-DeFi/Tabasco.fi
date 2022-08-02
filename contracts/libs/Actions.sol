// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


library Actions {
    // Possible Actions
    enum UserOptionActionType {
        ////@notice: User requests to purchases option
        RequestBuyOption,
        ////@notice: User requests to sells an option
        RequestSellOption,
        ////@notice: User cancels to purchases option
        CancelRequestBuyOption,
        ////@notice: User cancels to sell an option
        CancelRequestSellOption,

        ////@notice: Market maker accepts to purchases selling option from user
        AcceptBuyOption,
        ////@notice: Market maker accepts to sells an option to user
        AcceptSellOption,
        ////@notice: Market maker cancels bid to purchase user's auction
        CancelAcceptBuyOption,
        ////@notice: Market maker cancels bid to sell an option to user
        CancelAcceptSellOption,

        ////@notice: User/Market Maker buys an option
        BuyOption,
        ////@notice: User/Market Maker sells an option
        SellOption,

        ////@notice: User withdraw option position before actual option starts
        WithdrawOption,
        ////@notice: User/Market maker redeems the reward upon option expiration
        RedeemAuctionReward
    }

    enum ContractOptionActionType {
        ////@notice: Create a contract when Market maker agrees to buy/sell an option
        CreateOptionContract,
        ////@notice: (TBD) Destory a contract when option expires
        DestroyOptionContract
    }

    // Arguments for any type of action
    struct UserOptionActionArgs {
        //type of actions that is being performed in the system
        UserOptionActionType actionType;
        address owner;
        address secondAddress;
        address asset;
        uint256 contractId;
        uint256 amount;
        bytes data;
    }

    struct ContractOptionActionArgs {
        ContractOptionActionType actionTypes;
        address owner;
        address secondAddress;
        address asset;
        uint256 contractId;
        uint256 amount;
        bytes data;
    }

    enum AuctionActionType {
        /* User Auction Action */
        ////@notice: User request to buy an option from Market Maker
        RegisterBuyAuction,
        ////@notice: User request to cancel the registered option he/she previously registered
        DeregisterAuction,
        ////@notice: Users request to buy an option from Market Makers
        RequestOptionBuy,
        ////@notice: Users request to sell an option to Market Makers
        RequestOptionSell,

        /* Market Maker Auction Action */
        ////@notice: Market Maker bids an option requested by User
        BidAuction,
        ////@notice: Market Maker cancels the bid that he/she previously bidded
        CancelBid,
        ////@notice: Market Makers accept to buy an option from User
        AcceptOptionBuy,
        ////@notice: Market Makers accept to sell an option to User
        AcceptOptionSell
    }

    struct AuctionActionArgs {
        AuctionActionType actionType;
    }
}

