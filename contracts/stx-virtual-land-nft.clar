;; stx-virtual-land-nft
;; <add a description here>

;; STXVirtualLand Rental Contract
;; A decentralized virtual land rental system on Stacks blockchain
;; Version: 1.0.0

;; (impl-trait 'SP2PABAF9FTAJYNFZH93XENAJ8FVY99RRM50D2JG9.nft-trait.nft-trait)

;; Contract Name
(define-constant CONTRACT-NAME "STXVirtualLand")
(define-constant CONTRACT-VERSION "1.0.0")

;; Error Constants
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-token-not-found (err u102))
(define-constant err-already-rented (err u103))
(define-constant err-not-rented (err u104))
(define-constant err-rental-expired (err u105))
(define-constant err-invalid-rental-period (err u106))
(define-constant contract-owner tx-sender)

(define-constant MAX-RENTAL-PERIOD u52560) ;; example: max 1 year (52560 blocks)
(define-constant err-exceeds-max-rental (err u404))
(define-constant err-invalid-price (err u405))

;; Data Variables
(define-data-var last-token-id uint u0)
(define-map tokens
    { token-id: uint } 
    { owner: principal, uri: (string-utf8 256) })

(define-map rental-details
    { token-id: uint }
    {
        tenant: (optional principal),
        rental-start: (optional uint),
        rental-end: (optional uint),
        rental-price: (optional uint)
    })

;; Contract Info Functions
(define-read-only (get-contract-info)
    (ok {
        name: CONTRACT-NAME,
        version: CONTRACT-VERSION,
        owner: contract-owner
    }))

;; SIP-009 NFT Trait Functions
(define-read-only (get-last-token-id)
    (ok (var-get last-token-id)))

(define-read-only (get-token-uri (token-id uint))
    (match (map-get? tokens { token-id: token-id })
        entry (ok (get uri entry))
        (err err-token-not-found)))

(define-read-only (get-owner (token-id uint))
    (match (map-get? tokens { token-id: token-id })
        entry (ok (get owner entry))
        (err err-token-not-found)))

;; Rental Management Functions
(define-read-only (get-rental-details (token-id uint))
    (match (map-get? rental-details { token-id: token-id })
        entry (ok entry)
        (err err-token-not-found)))

(define-public (mint-stx-virtual-land (recipient principal) (uri (string-utf8 256)))
    (let ((token-id (+ (var-get last-token-id) u1)))
        (asserts! (is-eq tx-sender contract-owner) err-owner-only)
        (map-set tokens
            { token-id: token-id }
            { owner: recipient, uri: uri })
        (map-set rental-details
            { token-id: token-id }
            {
                tenant: none,
                rental-start: none,
                rental-end: none,
                rental-price: none
            })
        (var-set last-token-id token-id)
        (ok token-id)))