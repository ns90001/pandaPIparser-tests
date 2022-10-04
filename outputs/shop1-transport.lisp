(defdomain domain (
  (:operator (!drive ?v ?l1 ?l2)
    ;; preconditions
    (
      (type-vehicle ?v) (type-location ?l1) (type-location ?l2)
      (at ?v ?l1) (road ?l1 ?l2)
    )
    ;; delete effects
    ((at ?v ?l1))
    ;; add effects
    ((at ?v ?l2))
    1
  )
  (:operator (!noop ?v ?l2)
    ;; preconditions
    (
      (type-vehicle ?v) (type-location ?l2)
      (at ?v ?l2)
    )
    ;; delete effects
    ()
    ;; add effects
    ()
    1
  )
  (:operator (!pick-up ?v ?l ?p ?s1 ?s2)
    ;; preconditions
    (
      (type-vehicle ?v) (type-location ?l) (type-package ?p) (type-capacity-number ?s1) (type-capacity-number ?s2)
      (at ?v ?l) (at ?p ?l) (capacity-predecessor ?s1 ?s2) (capacity ?v ?s2)
    )
    ;; delete effects
    ((at ?p ?l) (capacity ?v ?s2))
    ;; add effects
    ((in ?p ?v) (capacity ?v ?s1))
    1
  )
  (:operator (!drop ?v ?l ?p ?s1 ?s2)
    ;; preconditions
    (
      (type-vehicle ?v) (type-location ?l) (type-package ?p) (type-capacity-number ?s1) (type-capacity-number ?s2)
      (at ?v ?l) (in ?p ?v) (capacity-predecessor ?s1 ?s2) (capacity ?v ?s1)
    )
    ;; delete effects
    ((in ?p ?v) (capacity ?v ?s1))
    ;; add effects
    ((at ?p ?l) (capacity ?v ?s2))
    1
  )
  (:method (x--top)
    x--top-method
    (
      
      (type-sort-for-city-loc-0 ?var-for-city-loc-0-1) (type-sort-for-package-0 ?var-for-package-0-2) (type-sort-for-city-loc-2 ?var-for-city-loc-2-3) (type-sort-for-package-1 ?var-for-package-1-4)
      
    )
    (:unordered (deliver ?var-for-package-0-2 ?var-for-city-loc-0-1) (deliver ?var-for-package-1-4 ?var-for-city-loc-2-3))
  )
  (:method (deliver ?p ?l2)
    m-deliver
    (
      (type-package ?p) (type-location ?l2)
      (type-package ?p) (type-location ?l1) (type-location ?l2) (type-vehicle ?v)
      
    )
    ((get-to ?v ?l1) (load ?v ?l1 ?p) (get-to ?v ?l2) (unload ?v ?l2 ?p))
  )
  (:method (get-to ?v ?l2)
    m-drive-to
    (
      (type-vehicle ?v) (type-location ?l2)
      (type-vehicle ?v) (type-location ?l1) (type-location ?l2)
      
    )
    ((!drive ?v ?l1 ?l2))
  )
  (:method (get-to ?v ?l3)
    m-drive-to-via
    (
      (type-vehicle ?v) (type-location ?l3)
      (type-vehicle ?v) (type-location ?l2) (type-location ?l3)
      
    )
    ((get-to ?v ?l2) (!drive ?v ?l2 ?l3))
  )
  (:method (get-to ?v ?l)
    m-i-am-there
    (
      (type-vehicle ?v) (type-location ?l)
      (type-vehicle ?v) (type-location ?l)
      
    )
    ((!noop ?v ?l))
  )
  (:method (load ?v ?l ?p)
    m-load
    (
      (type-vehicle ?v) (type-location ?l) (type-package ?p)
      (type-vehicle ?v) (type-location ?l) (type-package ?p) (type-capacity-number ?s1) (type-capacity-number ?s2)
      
    )
    ((!pick-up ?v ?l ?p ?s1 ?s2))
  )
  (:method (unload ?v ?l ?p)
    m-unload
    (
      (type-vehicle ?v) (type-location ?l) (type-package ?p)
      (type-vehicle ?v) (type-location ?l) (type-package ?p) (type-capacity-number ?s1) (type-capacity-number ?s2)
      
    )
    ((!drop ?v ?l ?p ?s1 ?s2))
  )
))
