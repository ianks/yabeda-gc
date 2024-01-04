# frozen_string_literal: true

RSpec.describe Yabeda::GC do
  it "has a version number" do
    expect(Yabeda::GC::VERSION).not_to be nil
  end

  subject { Yabeda.collect! }

  it "tracks metrics for GC" do
    expect { subject }.to(
      update_yabeda_gauge(Yabeda.gc.count).with(be_a(Integer))
      .and(update_yabeda_gauge(Yabeda.gc.heap_allocatable_pages).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_allocated_pages).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_available_slots).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_eden_pages).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_final_slots).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_free_slots).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_live_slots).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_marked_slots).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_sorted_length).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.heap_tomb_pages).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.major_gc_count).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.malloc_increase_bytes).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.malloc_increase_bytes_limit).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.minor_gc_count).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.old_objects).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.old_objects_limit).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.oldmalloc_increase_bytes).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.oldmalloc_increase_bytes_limit).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.remembered_wb_unprotected_objects).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.remembered_wb_unprotected_objects_limit).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.total_allocated_objects).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.total_allocated_pages).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.total_freed_objects).with(be_a(Integer)))
      .and(update_yabeda_gauge(Yabeda.gc.total_freed_pages).with(be_a(Integer)))
    )
  end

  if RUBY_VERSION >= "3.0"
    it "tracks ruby3 metrics for GC" do
      expect { subject }.to(
        update_yabeda_gauge(Yabeda.gc.read_barrier_faults).with(be_a(Integer))
          .and(update_yabeda_gauge(Yabeda.gc.total_moved_objects).with(be_a(Integer)))
      )
    end
  end

  if RUBY_VERSION >= "3.1"
    it "tracks Ruby 3.1 time metrics for GC" do
      expect { subject }.to update_yabeda_gauge(Yabeda.gc.time).with(be_a(Integer))
    end
  end

  if RUBY_VERSION >= "3.3"
    it "tracks Ruby 3.3 time metrics for GC" do
      expect { subject }.to(
        update_yabeda_gauge(Yabeda.gc.marking_time).with(be_a(Integer))
          .and(update_yabeda_gauge(Yabeda.gc.sweeping_time).with(be_a(Integer)))
      )
    end
  end
end
