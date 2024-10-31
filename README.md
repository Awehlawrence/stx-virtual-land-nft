# STXVirtualLand NFT Rental Contract

A decentralized contract for renting virtual land NFTs on the Stacks blockchain, enabling secure, on-chain rental agreements. Property owners can list their land tokens for rent, set rental periods and pricing, and enforce rental agreements via blockchain-based validation.

## Key Features

- **Minting of Virtual Land NFTs**: Allows contract owner to mint unique virtual land tokens and assign them to designated recipients.
- **Rental Listings**: Property owners can list their tokens for rent with a specified price and rental period.
- **Secure Rent Payments**: Renters transfer STX tokens as rent payments to property owners, secured on the blockchain.
- **Automatic Rental Expiry**: Manages the start and end dates of each rental period, allowing renters to access the land only during the valid rental period.
- **Rental Management and Expiry Checks**: Owners and authorized renters can query and manage rental status and receive alerts on expired rentals.

## Contract Structure and Components

### Constants

Defined constants include contract owner, maximum rental period, and standard error codes for handling exceptions.

### Data Variables and Maps

- `tokens` and `rental-details` maps hold owner information and current rental status for each token.

### Core Functions

- **Minting (`mint-stx-virtual-land`)**: Mints new land NFTs.
- **Rental Listing (`list-virtual-land-for-rent`)**: Lists tokens for rent with specified terms.
- **Renting (`rent-virtual-land`)**: Transfers rental payment and starts the rental period.
- **Ending Rentals (`end-virtual-land-rental`)**: Terminates the rental after the period expires or by authorized users.

### Read-only Functions

Includes `get-contract-info`, `get-rental-details`, `is-land-rented`, and other helper functions for efficient status tracking.

## Usage Example

### Minting

Owner mints land tokens and assigns to a recipient.

### Listing

Owner lists token on rental terms.

### Renting

Tenant initiates rental with rental payment; contract validates and starts rental period.

### Ending Rental

After rental expires, the contract automatically enforces access restrictions.

## Error Handling

Defines custom errors to ensure secure handling of operations:

- `err-owner-only`
- `err-not-token-owner`
- `err-already-rented`

Each addressing specific failure conditions.

## Deployment

1. Ensure Stacks wallet with sufficient balance.
2. Deploy to Stacks blockchain using the Clarity language.

## Testing

Test each function (minting, listing, renting, ending rentals) for edge cases, ensuring secure error handling and accurate rental management.