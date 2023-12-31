# frozen_string_literal: true

require "yabeda"
require "yabeda/gc/version"

module Yabeda
  # Yabeda plugin to capture important Ruby GC metrics
  module GC
    EMPTY_HASH = {}.freeze

    Yabeda.configure do
      group :gc

      gauge :count, tags: [], comment: "Count of all GCs"
      gauge :compact_count, tags: [], comment: "Count of all GC compactions"
      gauge :minor_gc_count, tags: [], comment: "Count of minor GCs"
      gauge :major_gc_count, tags: [], comment: "Count of major GCs"
      gauge :heap_allocated_pages, tags: [], comment: "Total number of pages allocated for the heap"
      gauge :heap_sorted_length, tags: [], comment: "Length of the sorted heap"
      gauge :heap_allocatable_pages, tags: [], comment: "Total number of allocatable heap pages"
      gauge :heap_available_slots, tags: [], comment: "Total number of slots in heap pages"
      gauge :heap_live_slots, tags: [], comment: "Number of live objects slots"
      gauge :heap_free_slots, tags: [], comment: "Number of free object slots"
      gauge :heap_final_slots, tags: [], comment: "Number of object slots with finalizers attached to them"
      gauge :heap_marked_slots, tags: [],
                                comment: "Count of old objects which survived more than 3 GC cycles and number of write-barrier unprotected objects"
      gauge :heap_eden_pages, tags: [], comment: "Number of pages allocated for the eden heap"
      gauge :heap_tomb_pages, tags: [], comment: "Number of pages allocated for the tomb heap"
      gauge :total_allocated_pages, tags: [],
                                    comment: "Total number of allocated pages over the lifetime of this process"
      gauge :total_freed_pages, tags: [], comment: "Total number of freed pages over the lifetime of this process"
      gauge :total_allocated_objects, tags: [],
                                      comment: "Total number of allocated objects over the lifetime of this process"
      gauge :total_freed_objects, tags: [], comment: "Total number of freed objects over the lifetime of this process"
      gauge :malloc_increase_bytes, tags: [], comment: "Total bytes allocated to objects"
      gauge :malloc_increase_bytes_limit, tags: [],
                                          comment: "Bytes limit that will trigger garbage collection of objects"
      gauge :remembered_wb_unprotected_objects, tags: [],
                                                comment: "Number of write-barrier unprotected objects in the remembered set"
      gauge :remembered_wb_unprotected_objects_limit, tags: [],
                                                      comment: "Limit on write-barrier unprotected objects allowed in the remembered set"
      gauge :old_objects, tags: [], comment: "Number of old objects"
      gauge :old_objects_limit, tags: [], comment: "Limit of old objects"
      gauge :oldmalloc_increase_bytes, tags: [], comment: "Total bytes allocated to old objects"
      gauge :oldmalloc_increase_bytes_limit, tags: [],
                                             comment: "Bytes limit that will trigger garbage collection of old objects"

      if RUBY_VERSION >= "3.0"
        gauge :time, tags: [], comment: "The total time spent in garbage collections"
        gauge :read_barrier_faults, tags: [], comment: "The total number of times the read barrier was triggered during compaction"
        gauge :total_moved_objects, tags: [], comment: "The total number of objects compaction has moved"
      end

      gauge :time, tags: [], comment: "The total time spent in garbage collections" if RUBY_VERSION >= "3.1"

      if RUBY_VERSION >= "3.3"
        gauge :marking_time, tags: [], comment: "Time spent in the marking phase" 
        gauge :sweeping_time, tags: [], comment: "Time spent in the sweeping phase"
      end

      collect do
        stats = ::GC.stat

        stats.each do |stat_name, value|
          __send__("gc_#{stat_name}").set(EMPTY_HASH, value)
        end
      end
    end
  end
end
