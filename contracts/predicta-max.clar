;; Title: PredictaMax - Next-Gen Bitcoin Price Forecasting Market
;;
;; Summary:
;; PredictaMax is a decentralized prediction protocol where users 
;; can leverage their market insights to forecast Bitcoin's price 
;; direction within defined timeframes. By staking STX tokens, 
;; participants collectively form a prediction pool, with rewards 
;; distributed fairly among accurate predictors.
;;
;; Description:
;; PredictaMax reimagines financial forecasting by fusing 
;; transparency, security, and game theory on the Stacks blockchain.
;; Each market is initialized with a start price, timeframe, and 
;; oracle-driven resolution. Users may stake on whether Bitcoin will 
;; rise ("up") or fall ("down") during the interval. At resolution, 
;; the winning side shares the reward pool, minus a protocol fee 
;; that sustains platform operations.
;;
;; Key Features:
;; - Fully decentralized, transparent prediction markets
;; - Oracle-driven settlement ensuring trustless outcomes
;; - Configurable minimum stake & protocol fee mechanisms
;; - Robust claim logic to eliminate double-claims
;; - Owner-governed parameters with on-chain transparency
;;
;; Security Highlights:
;; - Restricted administrative privileges
;; - Market resolution only by oracle
;; - Safeguards against invalid inputs & insufficient balances
;; - Controlled fee withdrawal by contract owner
;;
;; Smart Contract: PredictaMax

;; Constants

;; Administrative
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))

;; Error codes
(define-constant err-not-found (err u101))
(define-constant err-invalid-prediction (err u102))
(define-constant err-market-closed (err u103))
(define-constant err-already-claimed (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-parameter (err u106))

;; State Variables

;; Platform configuration
(define-data-var oracle-address principal 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)
(define-data-var minimum-stake uint u1000000) ;; 1 STX
(define-data-var fee-percentage uint u2) ;; 2%
(define-data-var market-counter uint u0)

;; Data Maps

;; Market registry
(define-map markets
  uint
  {
    start-price: uint,
    end-price: uint,
    total-up-stake: uint,
    total-down-stake: uint,
    start-block: uint,
    end-block: uint,
    resolved: bool,
  }
)

;; User predictions
(define-map user-predictions
  {
    market-id: uint,
    user: principal,
  }
  {
    prediction: (string-ascii 4),
    stake: uint,
    claimed: bool,
  }
)

;; Public Functions

;; Initialize a new market
(define-public (create-market
    (start-price uint)
    (start-block uint)
    (end-block uint)
  )
  (let ((market-id (var-get market-counter)))
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (asserts! (> end-block start-block) err-invalid-parameter)
    (asserts! (> start-price u0) err-invalid-parameter)