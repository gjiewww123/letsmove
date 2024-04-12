module my_coin::mycoin {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    struct MYCOIN has drop {}

    fun init(witness: MYCOIN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<MYCOIN>(witness, 6, b"MYCOIN", b"mc", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata); 
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));    
    }

    public entry fun mint(
        treasury_cap: &mut TreasuryCap<MYCOIN>, amount: u64, recipient: address, ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }
}
