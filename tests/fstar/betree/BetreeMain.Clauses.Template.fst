(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [betree_main]: templates for the decreases clauses *)
module BetreeMain.Clauses.Template
open Primitives
open BetreeMain.Types

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [betree_main::betree::List::{1}::len]: decreases clause *)
unfold
let betree_List_len_decreases (t : Type0) (self : betree_List_t t) : nat =
  admit ()

(** [betree_main::betree::List::{1}::split_at]: decreases clause *)
unfold
let betree_List_split_at_decreases (t : Type0) (self : betree_List_t t)
  (n : u64) : nat =
  admit ()

(** [betree_main::betree::List::{2}::partition_at_pivot]: decreases clause *)
unfold
let betree_List_partition_at_pivot_decreases (t : Type0)
  (self : betree_List_t (u64 & t)) (pivot : u64) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::lookup_first_message_for_key]: decreases clause *)
unfold
let betree_Node_lookup_first_message_for_key_decreases (key : u64)
  (msgs : betree_List_t (u64 & betree_Message_t)) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::apply_upserts]: decreases clause *)
unfold
let betree_Node_apply_upserts_decreases
  (msgs : betree_List_t (u64 & betree_Message_t)) (prev : option u64)
  (key : u64) (st : state) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::lookup_in_bindings]: decreases clause *)
unfold
let betree_Node_lookup_in_bindings_decreases (key : u64)
  (bindings : betree_List_t (u64 & u64)) : nat =
  admit ()

(** [betree_main::betree::Internal::{4}::lookup_in_children]: decreases clause *)
unfold
let betree_Internal_lookup_in_children_decreases (self : betree_Internal_t)
  (key : u64) (st : state) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::lookup]: decreases clause *)
unfold
let betree_Node_lookup_decreases (self : betree_Node_t) (key : u64)
  (st : state) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::filter_messages_for_key]: decreases clause *)
unfold
let betree_Node_filter_messages_for_key_decreases (key : u64)
  (msgs : betree_List_t (u64 & betree_Message_t)) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::lookup_first_message_after_key]: decreases clause *)
unfold
let betree_Node_lookup_first_message_after_key_decreases (key : u64)
  (msgs : betree_List_t (u64 & betree_Message_t)) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::apply_messages_to_internal]: decreases clause *)
unfold
let betree_Node_apply_messages_to_internal_decreases
  (msgs : betree_List_t (u64 & betree_Message_t))
  (new_msgs : betree_List_t (u64 & betree_Message_t)) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::lookup_mut_in_bindings]: decreases clause *)
unfold
let betree_Node_lookup_mut_in_bindings_decreases (key : u64)
  (bindings : betree_List_t (u64 & u64)) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::apply_messages_to_leaf]: decreases clause *)
unfold
let betree_Node_apply_messages_to_leaf_decreases
  (bindings : betree_List_t (u64 & u64))
  (new_msgs : betree_List_t (u64 & betree_Message_t)) : nat =
  admit ()

(** [betree_main::betree::Internal::{4}::flush]: decreases clause *)
unfold
let betree_Internal_flush_decreases (self : betree_Internal_t)
  (params : betree_Params_t) (node_id_cnt : betree_NodeIdCounter_t)
  (content : betree_List_t (u64 & betree_Message_t)) (st : state) : nat =
  admit ()

(** [betree_main::betree::Node::{5}::apply_messages]: decreases clause *)
unfold
let betree_Node_apply_messages_decreases (self : betree_Node_t)
  (params : betree_Params_t) (node_id_cnt : betree_NodeIdCounter_t)
  (msgs : betree_List_t (u64 & betree_Message_t)) (st : state) : nat =
  admit ()

