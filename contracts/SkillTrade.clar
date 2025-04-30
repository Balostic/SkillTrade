;; SkillTrade: P2P Professional Skills Exchange
;; Version: 1.0.0
(define-constant ERR-NOT-AUTHORIZED (err u1))
(define-constant ERR-SERVICE-NOT-FOUND (err u2))
(define-constant ERR-ALREADY-LISTED (err u3))
(define-constant ERR-INVALID-STATUS (err u4))
(define-constant ERR-INVALID-HOURS (err u5))
(define-constant ERR-INVALID-CATEGORY (err u6))
(define-constant ERR-INVALID-EXPERTISE (err u7))
(define-constant ERR-INVALID-TITLE (err u8))
(define-constant ERR-INVALID-DESCRIPTION (err u9))
(define-constant MIN-HOURS u1)
(define-data-var next-service-id uint u1)
(define-map services
    uint
    {
        provider: principal,
        service-title: (string-utf8 50),
        description: (string-utf8 200),
        category: (string-utf8 15),
        expertise: (string-utf8 20),
        status: (string-utf8 15),
        hours-available: uint
    }
)
(define-private (validate-category (category (string-utf8 15)))
    (or 
        (is-eq category u"Development")
        (is-eq category u"Design")
        (is-eq category u"Marketing")
        (is-eq category u"Writing")
        (is-eq category u"Consulting")
        (is-eq category u"Education")
    )
)
(define-private (validate-expertise (expertise (string-utf8 20)))
    (or 
        (is-eq expertise u"Beginner")
        (is-eq expertise u"Intermediate")
        (is-eq expertise u"Advanced")
        (is-eq expertise u"Expert")
        (is-eq expertise u"Master")
    )
)
(define-private (validate-text-length (text (string-utf8 200)) (min-length uint) (max-length uint))
    (let 
        (
            (text-length (len text))
        )
        (and 
            (>= text-length min-length)
            (<= text-length max-length)
        )
    )
)
(define-public (offer-service 
    (service-title (string-utf8 50))
    (description (string-utf8 200))
    (category (string-utf8 15))
    (expertise (string-utf8 20))
    (hours-available uint)
)
    (let
        (
            (service-id (var-get next-service-id))
        )
        (asserts! (validate-text-length service-title u3 u50) ERR-INVALID-TITLE)
        (asserts! (validate-text-length description u10 u200) ERR-INVALID-DESCRIPTION)
        (asserts! (>= hours-available MIN-HOURS) ERR-INVALID-HOURS)
        (asserts! (validate-category category) ERR-INVALID-CATEGORY)
        (asserts! (validate-expertise expertise) ERR-INVALID-EXPERTISE)
        
        (map-set services service-id {
            provider: tx-sender,
            service-title: service-title,
            description: description,
            category: category,
            expertise: expertise,
            status: u"available",
            hours-available: hours-available
        })
        (var-set next-service-id (+ service-id u1))
        (ok service-id)
    )
)
(define-public (remove-service (service-id uint))
    (let
        (
            (service (unwrap! (map-get? services service-id) ERR-SERVICE-NOT-FOUND))
        )
        (asserts! (is-eq tx-sender (get provider service)) ERR-NOT-AUTHORIZED)
        (asserts! (is-eq (get status service) u"available") ERR-INVALID-STATUS)
        (ok (map-set services service-id (merge service { status: u"unavailable" })))
    )
)
(define-read-only (get-service (service-id uint))
    (ok (map-get? services service-id))
)
(define-read-only (get-provider (service-id uint))
    (ok (get provider (unwrap! (map-get? services service-id) ERR-SERVICE-NOT-FOUND)))
)