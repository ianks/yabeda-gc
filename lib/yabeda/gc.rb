# frozen_string_literal: true

require "yabeda"
require "yabeda/gc/version"

module Yabeda
  # Yabeda plugin to capture important Ruby GC metrics
  module GC
    EMPTY_HASH = {}.freeze

    # Don't use a constant. No need to retain this after registering gauges.
    comments = {
      count: "Count of all GCs",
      compact_count: "Count of all GC compactions",
      minor_gc_count: "Count of minor GCs",
      major_gc_count: "Count of major GCs",
      heap_allocated_pages: "Total number of pages allocated for the heap",
      heap_sorted_length: "Length of the sorted heap",
      heap_allocatable_pages: "Total number of allocatable heap pages",
      heap_available_slots: "Total number of slots in heap pages",
      heap_live_slots: "Number of live objects slots",
      heap_free_slots: "Number of free object slots",
      heap_final_slots: "Number of object slots with finalizers attached to them",
      heap_marked_slots: "Count of old objects which survived more than 3 GC cycles and number of write-barrier unprotected objects",
      heap_eden_pages: "Number of pages allocated for the eden heap",
      heap_tomb_pages: "Number of pages allocated for the tomb heap",
      total_allocated_pages: "Total number of allocated pages over the lifetime of this process",
      total_freed_pages: "Total number of freed pages over the lifetime of this process",
      total_allocated_objects: "Total number of allocated objects over the lifetime of this process",
      total_freed_objects: "Total number of freed objects over the lifetime of this process",
      malloc_increase_bytes: "Total bytes allocated to objects",
      malloc_increase_bytes_limit: "Bytes limit that will trigger garbage collection of objects",
      remembered_wb_unprotected_objects: "Number of write-barrier unprotected objects in the remembered set",
      remembered_wb_unprotected_objects_limit: "Limit on write-barrier unprotected objects allowed in the remembered set",
      old_objects: "Number of old objects",
      old_objects_limit: "Limit of old objects",
      oldmalloc_increase_bytes: "Total bytes allocated to old objects",
      oldmalloc_increase_bytes_limit: "Bytes limit that will trigger garbage collection of old objects",

      # Ruby 3.0
      time: "The total time spent in garbage collections",
      read_barrier_faults: "The total number of times the read barrier was triggered during compaction",
      total_moved_objects: "The total number of objects compaction has moved",

      # Ruby 3.3
      marking_time: "Time spent in the marking phase",
      sweeping_time: "Time spent in the sweeping phase"
    }.freeze

    Yabeda.configure do
      group :gc

      # Register gauges for all GC stats. Include our optional commentary.
      ::GC.stat.each_key do |stat_name|
        gauge stat_name, tags: [], comment: comments.fetch(stat_name, stat_name)
      end

      collect do
        stats = ::GC.stat

        stats.each do |stat_name, value|
          next unless ::Yabeda.gc.respond_to?(stat_name)

          ::Yabeda.gc.__send__(stat_name).set(EMPTY_HASH, value)
        end
      end
    end
  end
end
