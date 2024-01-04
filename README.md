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
|-------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| `count`                                   | Count of all GCs                                                                                          |
| `time`                                    | The total time spent in garbage collections (ruby 3+)                                                     |
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
| `read_barrier_faults`                     | The total number of times the read barrier was triggered during compaction (ruby 3+)                      |
| `total_moved_objects`                     | The total number of objects compaction has moved (ruby 3+)                                                |
| `marking_time`                            | The total time spent in marking phase (ruby 3.3+)                                                         |
| `sweeping_time`                           | The total time spent in sweeping phase (ruby 3.3+)                                                        |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Releasing

1. Bump version number in `lib/yabeda/gc/version.rb`

   In case of pre-releases keep in mind [rubygems/rubygems#3086](https://github.com/rubygems/rubygems/issues/3086) and check version with command like `Gem::Version.new(Yabeda::gc::VERSION).to_s`

2. Fill `CHANGELOG.md` with missing changes, add header with version and date.

3. Make a commit:

   ```sh
   bundle # to update Gemfile.lock
   git add lib/yabeda/gc/version.rb CHANGELOG.md Gemfile.lock
   version=$(ruby -r ./lib/yabeda/gc/version.rb -e "puts Gem::Version.new(Yabeda::GC::VERSION)")
   git commit --message="${version}: " --edit
   ```

4. Create annotated tag:

   ```sh
   git tag v${version} --annotate --message="${version}: " --edit --sign
   ```

5. Fill version name into subject line and (optionally) some description (list of changes will be taken from changelog and appended automatically)

6. Push it:

   ```sh
   git push --follow-tags
   ```

7. GitHub Actions will create a new release, build and push gem into RubyGems! You're done!

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ianks/yabeda-gc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ianks/yabeda-gc/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Yabeda::GC project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ianks/yabeda-gc/blob/master/CODE_OF_CONDUCT.md).
