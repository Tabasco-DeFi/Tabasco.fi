// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library Actions {
    enum ActionType {
        Lend,
        Withdraw,
        Borrow,
        Repay,
        Transfer
    }

    //// @dev General Action arguments
    struct ActionArgs {
        ////@notice: Type of action to execute
        ActionType actionType;
        ////@notice: Address of the account owner or message sender
        address sender;
        ////@notice: Asset that is to be transferred (contract address)
        ////@notice: if isLender == True, collateral == asset
        address asset;
        ////@notice: Type of pool to withdraw/deposit from/to
        uint256 poolId;
        ////@notice: check user status [Lender | Borrower]
        uint256 amount;
        ////@notice: Interest that has to be repaid by borrower
        uint256 interest;
        ////@notice: check if user has previously deposit asset
        bool hasDeposit;
    }

    struct LendAssetArgs {
        ActionType actionType;
        address sender;
        address asset;
        uint256 poolId;
        bool isLender;
        uint256 amount;
        bool hasDeposit;
    }

    struct WithdrawAssetArgs {
        ActionType actionType;
        address sender;
        address asset;
        uint256 poolId;
        uint256 amount;
    }

    struct BorrowAssertArgs {
        ActionType actionType;
        address sender;
        address asset;
        uint256 poolId;
        bool isLender;
        uint256 amount;
        uint256 interest;
        bool hasDeposit;
    }

    struct RepayAssertArgs {
        ActionType actionType;
        address sender;
        address asset;
        uint256 poolId;
        uint256 amount;
    }

    function _setLendAssetArgs(ActionArgs memory _args) internal view returns(LendAssetArgs memory) {
        // Check Lending amount > 0
        require(_args.amount > 0);
        // Check user has enough tokens to transfer
        require(_args.amount <= IERC20(_args.asset).balanceOf(_args.sender));
        // Check null address
        require(_args.sender != address(0));

        return LendAssetArgs({
            actionType: _args.actionType,
            sender: _args.sender,
            asset: _args.asset,
            poolId: _args.poolId,
            isLender: true,
            amount: _args.amount,
            hasDeposit: true
        });
    }

    function _setBorrowAssetArgs(ActionArgs memory _args) internal view returns(BorrowAssertArgs memory) {
        // Check Lending amount > 0
        require(_args.amount > 0);
        // Check user has enough tokens to transfer
        require(_args.amount <= IERC20(_args.asset).balanceOf(_args.sender));
        // Check null address
        require(_args.sender != address(0));

        return BorrowAssertArgs({
            actionType: _args.actionType,
            sender: _args.sender,
            asset: _args.asset,
            poolId: _args.poolId,
            isLender: false,
            amount: _args.amount,
            interest: _args.interest,
            hasDeposit: true
        });
    }

    function _setWithdrawAssetArgs(ActionArgs memory _args) internal view returns(WithdrawAssetArgs memory) {
        // Check Lending amount > 0
        require(_args.amount > 0);
        // Check user has enough tokens to transfer
        require(_args.amount <= IERC20(_args.asset).balanceOf(_args.sender));
        // Check null address
        require(_args.sender != address(0));
        require(_args.hasDeposit);

        return WithdrawAssetArgs({
            actionType: _args.actionType,
            sender: _args.sender,
            asset: _args.asset,
            poolId: _args.poolId,
            amount: _args.amount
        });
    }

    function _setRepayAssetArgs(ActionArgs memory _args) internal view returns(RepayAssertArgs memory) {
        // Check Lending amount > 0
        require(_args.amount > 0);
        // Check user has enough tokens to transfer
        require(_args.amount <= IERC20(_args.asset).balanceOf(_args.sender));
        // Check null address
        require(_args.sender != address(0));
        require(_args.hasDeposit);

        return RepayAssertArgs({
            actionType: _args.actionType,
            sender: _args.sender,
            asset: _args.asset,
            poolId: _args.poolId,
            amount: _args.amount
        });
    }
}