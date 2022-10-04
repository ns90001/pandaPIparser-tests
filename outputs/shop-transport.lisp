(defdomain domain (
  (:operator (!drive ?v ?l1 ?l2)
    ;; preconditions
    (
      (type_vehicle ?v) (type_location ?l1) (type_location ?l2)
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
      (type_vehicle ?v) (type_location ?l2)
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
      (type_vehicle ?v) (type_location ?l) (type_package ?p) (type_capacity-number ?s1) (type_capacity-number ?s2)
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
      (type_vehicle ?v) (type_location ?l) (type_package ?p) (type_capacity-number ?s1) (type_capacity-number ?s2)
      (at ?v ?l) (in ?p ?v) (capacity-predecessor ?s1 ?s2) (capacity ?v ?s1)
    )
    ;; delete effects
    ((in ?p ?v) (capacity ?v ?s1))
    ;; add effects
    ((at ?p ?l) (capacity ?v ?s2))
    1
  )
  (:method (__top)
    __top_method
    (
      
      (type_sort_for_city-loc-0 ?var_for_city-loc-0_1) (type_sort_for_package-0 ?var_for_package-0_2) (type_sort_for_city-loc-2 ?var_for_city-loc-2_3) (type_sort_for_package-1 ?var_for_package-1_4)
      
    )
    (:unordered (deliver ?var_for_package-0_2 ?var_for_city-loc-0_1) (deliver ?var_for_package-1_4 ?var_for_city-loc-2_3))
  )
  (:method (deliver ?p ?l2)
    m-deliver
    (
      (type_package ?p) (type_location ?l2)
      (type_package ?p) (type_location ?l1) (type_location ?l2) (type_vehicle ?v)
      
    )
    ((get-to ?v ?l1) (load ?v ?l1 ?p) (get-to ?v ?l2) (unload ?v ?l2 ?p))
  )
  (:method (get-to ?v ?l2)
    m-drive-to
    (
      (type_vehicle ?v) (type_location ?l2)
      (type_vehicle ?v) (type_location ?l1) (type_location ?l2)
      
    )
    ((!drive ?v ?l1 ?l2))
  )
  (:method (get-to ?v ?l3)
    m-drive-to-via
    (
      (type_vehicle ?v) (type_location ?l3)
      (type_vehicle ?v) (type_location ?l2) (type_location ?l3)
      
    )
    ((get-to ?v ?l2) (!drive ?v ?l2 ?l3))
  )
  (:method (get-to ?v ?l)
    m-i-am-there
    (
      (type_vehicle ?v) (type_location ?l)
      (type_vehicle ?v) (type_location ?l)
      
    )
    ((!noop ?v ?l))
  )
  (:method (load ?v ?l ?p)
    m-load
    (
      (type_vehicle ?v) (type_location ?l) (type_package ?p)
      (type_vehicle ?v) (type_location ?l) (type_package ?p) (type_capacity-number ?s1) (type_capacity-number ?s2)
      
    )
    ((!pick-up ?v ?l ?p ?s1 ?s2))
  )
  (:method (unload ?v ?l ?p)
    m-unload
    (
      (type_vehicle ?v) (type_location ?l) (type_package ?p)
      (type_vehicle ?v) (type_location ?l) (type_package ?p) (type_capacity-number ?s1) (type_capacity-number ?s2)
      
    )
    ((!drop ?v ?l ?p ?s1 ?s2))
  )
))
