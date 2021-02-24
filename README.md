# Yabeda::GC

Built in metrics for monitoring the Ruby garbage collector. Part of the [yabeda](https://github.com/yabeda-rb/yabeda) suite.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yabeda-gc'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install yabeda-gc

## Metrics

| Metric                                    | Description                                                                                               |
| ----------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `count`                                   | Count of all GCs                                                                                          |
| `minor_gc_count`                          | Count of minor GCs                                                                                        |
| `major_gc_count`                          | Count of major GCs                                                                                        |
| `heap_allocated_pages`                    | Total number of pages allocated for the heap                                                              |
| `heap_sorted_length`                      | Length of the sorted heap                                                                                 |
| `heap_allocatable_pages`                  | Total number of allocatable heap pages                                                                    |
| `heap_available_slots`                    | Total number of slots in heap pages                                                                       |
| `heap_live_slots`                         | Number of live objects slots                                                                              |
| `heap_free_slots`                         | Number of free object slots                                                                               |
| `heap_final_slots`                        | Number of object slots with finalizers attached to them                                                   |
| `heap_marked_slots`                       | Count of old objects which survived more than 3 GC cycles and number of write-barrier unprotected objects |
| `heap_eden_pages`                         | Number of pages allocated for the eden heap                                                               |
| `heap_tomb_pages`                         | Number of pages allocated for the tomb heap                                                               |
| `total_allocated_pages`                   | Total number of allocated pages over the lifetime of this process                                         |
| `total_freed_pages`                       | Total number of freed pages over the lifetime of this process                                             |
| `total_allocated_objects`                 | Total number of allocated objects over the lifetime of this process                                       |
| `total_freed_objects`                     | Total number of freed objects over the lifetime of this process                                           |
| `malloc_increase_bytes`                   | Total bytes allocated to objects                                                                          |
| `malloc_increase_bytes_limit`             | Bytes limit that will trigger garbage collection of objects                                               |
| `remembered_wb_unprotected_objects`       | Number of write-barrier unprotected objects in the remembered set                                         |
| `remembered_wb_unprotected_objects_limit` | Limit on write-barrier unprotected objects allowed in the remembered set                                  |
| `old_objects`                             | Number of old objects                                                                                     |
| `old_objects_limit`                       | Limit of old objects                                                                                      |
| `oldmalloc_increase_bytes`                | Total bytes allocated to old objects                                                                      |
| `oldmalloc_increase_bytes_limit`          | Bytes limit that will trigger garbage collection of old objects                                           |
| `compact_count`                           | Count of all GC compactions                                                                               |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ianks/yabeda-gc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ianks/yabeda-gc/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yabeda::GC project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ianks/yabeda-gc/blob/master/CODE_OF_CONDUCT.md).
