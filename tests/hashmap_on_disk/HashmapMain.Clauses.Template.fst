(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [hashmap_main]: templates for the decreases clauses *)
module HashmapMain.Clauses.Template
open Primitives
open HashmapMain.Types

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [hashmap_main::hashmap::HashMap::{0}::allocate_slots]: decreases clause *)
unfold
let hashmap_hash_map_allocate_slots_decreases (t : Type0)
  (slots : vec (hashmap_list_t t)) (n : usize) : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::clear_slots]: decreases clause *)
unfold
let hashmap_hash_map_clear_slots_decreases (t : Type0)
  (slots : vec (hashmap_list_t t)) (i : usize) : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::insert_in_list]: decreases clause *)
unfold
let hashmap_hash_map_insert_in_list_decreases (t : Type0) (key : usize)
  (value : t) (ls : hashmap_list_t t) : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::move_elements_from_list]: decreases clause *)
unfold
let hashmap_hash_map_move_elements_from_list_decreases (t : Type0)
  (ntable : hashmap_hash_map_t t) (ls : hashmap_list_t t) : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::move_elements]: decreases clause *)
unfold
let hashmap_hash_map_move_elements_decreases (t : Type0)
  (ntable : hashmap_hash_map_t t) (slots : vec (hashmap_list_t t)) (i : usize)
  : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::contains_key_in_list]: decreases clause *)
unfold
let hashmap_hash_map_contains_key_in_list_decreases (t : Type0) (key : usize)
  (ls : hashmap_list_t t) : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::get_in_list]: decreases clause *)
unfold
let hashmap_hash_map_get_in_list_decreases (t : Type0) (key : usize)
  (ls : hashmap_list_t t) : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list]: decreases clause *)
unfold
let hashmap_hash_map_get_mut_in_list_decreases (t : Type0) (key : usize)
  (ls : hashmap_list_t t) : nat =
  admit ()

(** [hashmap_main::hashmap::HashMap::{0}::remove_from_list]: decreases clause *)
unfold
let hashmap_hash_map_remove_from_list_decreases (t : Type0) (key : usize)
  (ls : hashmap_list_t t) : nat =
  admit ()

