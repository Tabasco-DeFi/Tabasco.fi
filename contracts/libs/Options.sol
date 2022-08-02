// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

library Products {
    struct Option {
        // Id of the option product
        uint256 optionId;

        // option Stirke price
        uint256 strikePrice;

        // option collateral which option seller has to pay. 0 if not option seller
        uint256 optionCollateral;

        // option start time
        uint32 optionStartTime;

        // time of contract formation
        uint32 optionCreationTime;

        // option end time
        uint32 optionEndTime;

        // check option has been exercised
        bool exercised;

        // check option has been canceled
        bool canceled;

        // The last updated price for exercising an option
        uint256 lastestCost;
        
        // address of option writer
        address optionWriter;

        // address of option seller
        address optionBuyer;
    }

}

library Users {
    enum UserType {
        User,
        MarketMaker,
        Manager
    }

    struct User {
        Products.Option[] option;
        UserType usertype;
    }
}
}

/**
Auction 
-> Auction status [Open | Close]
-> Highest Bidder
-> Highest Bid (Start with starting bid)
-> 
*/
    