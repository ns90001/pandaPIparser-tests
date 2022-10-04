(define (domain dom)
  (:requirements 
    :typing
    :htn-expansion
    :negative-preconditions
    :conditional-effects
    :universal-preconditions
    :disjuntive-preconditions
    :equality
    :existential-preconditions
  )
  (:types 
    target locatable location - object__compiled
    package vehicle - locatable
    capacity-number - object__compiled
 object__compiled - object  )

  (:constants
    city-loc-0 city-loc-2 - location
    package-0 package-1 - package
  )

  (:predicates
    (type_member_capacity-number ?var - object)
    (type_member_locatable ?var - object)
    (type_member_location ?var - object)
    (type_member_object__compiled ?var - object)
    (type_member_package ?var - object)
    (type_member_target ?var - object)
    (type_member_vehicle ?var - object)
    (road ?var0 - location ?var1 - location)
    (at ?var0 - locatable ?var1 - location)
    (in ?var0 - package ?var1 - vehicle)
    (capacity ?var0 - vehicle ?var1 - capacity-number)
    (capacity-predecessor ?var0 - capacity-number ?var1 - capacity-number)
  )


  (:task drive
    :parameters (?v - object ?l1 - object ?l2 - object)
    (:method method1
      :precondition (and
        (type_member_vehicle ?v)
        (type_member_location ?l1)
        (type_member_location ?l2)
      )
      :tasks (
        (drive_primitive ?v - vehicle ?l1 - location ?l2 - location)
      )
    )
  )

  (:task noop
    :parameters (?v - object ?l2 - object)
    (:method method1
      :precondition (and
        (type_member_vehicle ?v)
        (type_member_location ?l2)
      )
      :tasks (
        (noop_primitive ?v - vehicle ?l2 - location)
      )
    )
  )

  (:task pick-up
    :parameters (?v - object ?l - object ?p - object ?s1 - object ?s2 - object)
    (:method method1
      :precondition (and
        (type_member_vehicle ?v)
        (type_member_location ?l)
        (type_member_package ?p)
        (type_member_capacity-number ?s1)
        (type_member_capacity-number ?s2)
      )
      :tasks (
        (pick-up_primitive ?v - vehicle ?l - location ?p - package ?s1 - capacity-number ?s2 - capacity-number)
      )
    )
  )

  (:task drop
    :parameters (?v - object ?l - object ?p - object ?s1 - object ?s2 - object)
    (:method method1
      :precondition (and
        (type_member_vehicle ?v)
        (type_member_location ?l)
        (type_member_package ?p)
        (type_member_capacity-number ?s1)
        (type_member_capacity-number ?s2)
      )
      :tasks (
        (drop_primitive ?v - vehicle ?l - location ?p - package ?s1 - capacity-number ?s2 - capacity-number)
      )
    )
  )

; ************************************************************
; ************************************************************
  (:task deliver
    :parameters (?p - package ?l - location)
    (:method m-deliver
      :precondition (and
        (type_member_package ?p - package)
        (type_member_location ?l1 - location)
        (type_member_location ?l - location)
        (type_member_vehicle ?v - vehicle)
      )
      :tasks (
        (get-to ?v ?l1)
        (load ?v ?l1 ?p)
        (get-to ?v ?l)
        (unload ?v ?l ?p)
      )
    )
  )

  (:task get-to
    :parameters (?v - vehicle ?l - location)
    (:method m-drive-to
      :precondition (and
        (type_member_vehicle ?v - vehicle)
        (type_member_location ?l1 - location)
        (type_member_location ?l - location)
      )
      :tasks (
        (drive ?v ?l1 ?l)
      )
    )
    (:method m-drive-to-via
      :precondition (and
        (type_member_vehicle ?v - vehicle)
        (type_member_location ?l2 - location)
        (type_member_location ?l - location)
      )
      :tasks (
        (get-to ?v ?l2)
        (drive ?v ?l2 ?l)
      )
    )
    (:method m-i-am-there
      :precondition (and
        (type_member_vehicle ?v - vehicle)
        (type_member_location ?l - location)
      )
      :tasks (
        (noop ?v ?l)
      )
    )
  )

  (:task load
    :parameters (?v - vehicle ?l - location ?p - package)
    (:method m-load
      :precondition (and
        (type_member_vehicle ?v - vehicle)
        (type_member_location ?l - location)
        (type_member_package ?p - package)
        (type_member_capacity-number ?s1 - capacity-number)
        (type_member_capacity-number ?s2 - capacity-number)
      )
      :tasks (
        (pick-up ?v ?l ?p ?s1 ?s2)
      )
    )
  )

  (:task unload
    :parameters (?v - vehicle ?l - location ?p - package)
    (:method m-unload
      :precondition (and
        (type_member_vehicle ?v - vehicle)
        (type_member_location ?l - location)
        (type_member_package ?p - package)
        (type_member_capacity-number ?s1 - capacity-number)
        (type_member_capacity-number ?s2 - capacity-number)
      )
      :tasks (
        (drop ?v ?l ?p ?s1 ?s2)
      )
    )
  )

  (:action drive_primitive
    :parameters (?v - vehicle ?l1 - location ?l2 - location)
    :precondition (and
      (at ?v ?l1)
      (road ?l1 ?l2)
    )
    :effect (and
      (not (at ?v ?l1))
      (at ?v ?l2)
    )
  )

  (:action noop_primitive
    :parameters (?v - vehicle ?l2 - location)
    :precondition (and
      (at ?v ?l2)
    )
    :effect (
    )
  )

  (:action pick-up_primitive
    :parameters (?v - vehicle ?l - location ?p - package ?s1 - capacity-number ?s2 - capacity-number)
    :precondition (and
      (at ?v ?l)
      (at ?p ?l)
      (capacity-predecessor ?s1 ?s2)
      (capacity ?v ?s2)
    )
    :effect (and
      (not (at ?p ?l))
      (in ?p ?v)
      (capacity ?v ?s1)
      (not (capacity ?v ?s2))
    )
  )

  (:action drop_primitive
    :parameters (?v - vehicle ?l - location ?p - package ?s1 - capacity-number ?s2 - capacity-number)
    :precondition (and
      (at ?v ?l)
      (in ?p ?v)
      (capacity-predecessor ?s1 ?s2)
      (capacity ?v ?s1)
    )
    :effect (and
      (not (in ?p ?v))
      (at ?p ?l)
      (capacity ?v ?s2)
      (not (capacity ?v ?s1))
    )
  )

)
