(define (problem prob) (:domain dom)
  (:objects
    capacity-0 capacity-1 - capacity-number
    city-loc-1 - location
    truck-0 - vehicle
  )

  (:init
    (capacity-predecessor capacity-0 capacity-1)
    (road city-loc-0 city-loc-1)
    (road city-loc-1 city-loc-0)
    (road city-loc-1 city-loc-2)
    (road city-loc-2 city-loc-1)
    (at package-0 city-loc-1)
    (at package-1 city-loc-1)
    (at truck-0 city-loc-2)
    (capacity truck-0 capacity-1)
    (type_member_capacity-number capacity-0)
    (type_member_capacity-number capacity-1)
    (type_member_locatable package-0)
    (type_member_locatable package-1)
    (type_member_locatable truck-0)
    (type_member_location city-loc-0)
    (type_member_location city-loc-1)
    (type_member_location city-loc-2)
    (type_member_object__compiled capacity-0)
    (type_member_object__compiled capacity-1)
    (type_member_object__compiled city-loc-0)
    (type_member_object__compiled city-loc-1)
    (type_member_object__compiled city-loc-2)
    (type_member_object__compiled package-0)
    (type_member_object__compiled package-1)
    (type_member_object__compiled truck-0)
    (type_member_package package-0)
    (type_member_package package-1)
    (type_member_vehicle truck-0)
  )

  (:tasks-goal
      :tasks [
        (deliver package-0 city-loc-0)
        (deliver package-1 city-loc-2)
      ]
  )
)
