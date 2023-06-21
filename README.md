# Bank tech test

## Description

A tech test as part of Makers 'Code Quality' week.

### Specification: Requirements

* You should be able to interact with your code via a REPL like IRB or Node.  (You don't need to implement a command line interface that takes input from STDIN.)
* Deposits, withdrawal.
* Account statement (date, amount, balance) printing.
* Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Specification: Acceptance criteria

**Given** a client makes a deposit of 1000 on 10-01-2023  
**And** a deposit of 2000 on 13-01-2023  
**And** a withdrawal of 500 on 14-01-2023  
**When** she prints her bank statement  
**Then** she would see

```shell
date || credit || debit || balance
14/01/2023 || || 500.00 || 2500.00
13/01/2023 || 2000.00 || || 3000.00
10/01/2023 || 1000.00 || || 1000.00
```

## How to use

Clone the repo, and navigate to the project directory.

### To install dependencies

Run:

```shell
bundle install
```

### To run the tests

Run:

```shell
rspec
```

You'll see that all tests are passing, with 100% test coverage. If you run `rubocop` you'll see that I have no RuboCop offences, _pace_ the configuration changes I have made in `.rubocop.yml` (mainly to exempt the spec files).

### To run the project

Open an `irb` session, requiring in the three Ruby files in `./lib`. Use instances of the classes, as in the below example, to see the program meeting the acceptance criteria:

```ruby
transaction1 = Transaction.new(1000, '10-01-2023')
transaction2 = Transaction.new(2000, '13-01-2023')
transaction3 = Transaction.new(-500, '14-01-2023')

account = Account.new
account.add(transaction1)
account.add(transaction2)
account.add(transaction3)

statement = Statement.new(account, $stdout)
statement.print_statement
```

A screenshot of this in action, using a scratch Ruby file rather than the REPL:
<img src="images/bank_tech_test_running.png" alt="Screenshot of the above code example running, printing a statement to the console" height="400"/>

## My approach

<img src="images/paper_diagram.jpg" alt="Photo of my working diagram on paper" height="400"/>
