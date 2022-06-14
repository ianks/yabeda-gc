# frozen_string_literal: true

RSpec.describe Yabeda::GC do
  before do
    ::GC.stat.keys.each do |method_name|
      Yabeda.gc.__send__(method_name).values.clear
    end
  end

  it "has a version number" do
    expect(Yabeda::GC::VERSION).not_to be nil
  end

  it "tracks metrics for GC" do
    Yabeda.collectors.each(&:call)

    expect(summary).to include(
      count: { {} => be_a(Integer) },
      heap_allocatable_pages: { {} => be_a(Integer) },
      heap_allocated_pages: { {} => be_a(Integer) },
      heap_available_slots: { {} => be_a(Integer) },
      heap_eden_pages: { {} => be_a(Integer) },
      heap_final_slots: { {} => be_a(Integer) },
      heap_free_slots: { {} => be_a(Integer) },
      heap_live_slots: { {} => be_a(Integer) },
      heap_marked_slots: { {} => be_a(Integer) },
      heap_sorted_length: { {} => be_a(Integer) },
      heap_tomb_pages: { {} => be_a(Integer) },
      major_gc_count: { {} => be_a(Integer) },
      malloc_increase_bytes: { {} => be_a(Integer) },
      malloc_increase_bytes_limit: { {} => be_a(Integer) },
      minor_gc_count: { {} => be_a(Integer) },
      old_objects: { {} => be_a(Integer) },
      old_objects_limit: { {} => be_a(Integer) },
      oldmalloc_increase_bytes: { {} => be_a(Integer) },
      oldmalloc_increase_bytes_limit: { {} => be_a(Integer) },
      remembered_wb_unprotected_objects: { {} => be_a(Integer) },
      remembered_wb_unprotected_objects_limit: { {} => be_a(Integer) },
      total_allocated_objects: { {} => be_a(Integer) },
      total_allocated_pages: { {} => be_a(Integer) },
      total_freed_objects: { {} => be_a(Integer) },
      total_freed_pages: { {} => be_a(Integer) }
    )
  end

  if RUBY_VERSION >= '3.0'
    it "tracks ruby3 metrics for GC" do
      Yabeda.collectors.each(&:call)

      expect(summary).to include(
        time: { {} => be_a(Integer) },
        read_barrier_faults: { {} => be_a(Integer) },
        total_moved_objects: { {} => be_a(Integer) }
      )
    end
  end

  def summary
    result = {}

    ::GC.stat.keys.each do |method_name|
      metric = Yabeda.gc.__send__(method_name)
      result[metric.name] = metric.values
    end

    result
  end
end
