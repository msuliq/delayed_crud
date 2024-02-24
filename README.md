# DelayedCrud

The `delayed_crud` gem simplifies database CRUD operations in your Ruby on Rails applications by utilizing preconfigured Sidekiq background jobs.

## Installation
To install the gem run the following command in the terminal:

  $ bundle add delayed_crud

If bundler is not being used to manage dependencies, install the gem by executing:

  $ gem install delayed_crud

## Usage

This gem provides three convenient methods for common CRUD operations, each accepting timer arguments with keywords `:in` and `:after`. Please note that the timer starts counting down as soon as the code line is executed. Since the gem relies on `sidekiq`, the execution timing might not be precise.

### delayed_create
The `delayed_create` method can be used on a model instance and accepts instance attributes in a hash along with a timer argument.

```ruby
  Customer.delayed_create({ status: :new }, in: 10.minutes.from_now)
```

### delayed_update
The `delayed_update` method works on an existing record and accepts update attributes in a hash along with a timer argument.

```ruby
  HeatedDiscussion.delayed_update({ frozen: false }, after: 24.hours)
```

### delayed_destroy
The `delayed_destroy` method can be used on an existing record and accepts only a timer argument. The record will be destroyed once the timer expires.

```ruby
TrialAccount.delayed_destroy(in: 1.week.from_now)
```

## Contributing

The best way to contribute would be to fork this repo, create a new branch from main, to merge the branch into main of the fork once the new code is in place and then open a pull request to merge forked main into the main of the present repo.

Bug reports and pull requests are welcome on GitHub at https://github.com/msuliq/delayed_crud. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/msuliq/delayed_crud/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DelayedCrud project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/msuliq/delayed_crud/blob/main/CODE_OF_CONDUCT.md).
