// Starknet deps

use starknet::{ContractAddress, contract_address_const};

// External deps
use snforge_std as snf;
use snforge_std::{CheatTarget, ContractClassTrait, EventSpy, SpyOn, start_prank, stop_prank};

// Contracts

use erc721::contracts::ERC721::{
    ERC721Contract, IExternalDispatcher as IERC721Dispatcher,
    IExternalDispatcherTrait as IERC721DispatcherTrait
};


///
/// Deploy and setup functions
/// 

fn deploy_project(
    name: felt252,
    symbol: felt252,
) -> (ContractAddress, EventSpy) {
    let contract = snf::declare('ERC721Contract');

    let mut calldata: Array<felt252> = array![
        name,
        symbol
    ];
    let contract_address = contract.deploy(@calldata).unwrap();

    let mut spy = snf::spy_events(SpyOn::One(contract_address));

    (contract_address, spy)
}