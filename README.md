# SharpSpec

**SharpSpec** is a lightweight Ruby DSL that lets you define expectations directly in your code comments — and auto-generates RSpec tests from them. It's a fast, extensible, and expressive way to prototype and validate code behavior through inline specifications.

> ⚠️ **Beta Notice**: SharpSpec is still in early development. Installation and usage will be simplified in a later release.

---

## 🚧 Installation

**Not available yet.**  
For now, use SharpSpec by cloning the repository and running it locally as a CLI tool.

---

## 🧠 How It Works

SharpSpec reads comment block above methods starting and ending with `# spec:begin` and `# spec:end`

Inside theses block you need to define details of your tests using theses options: 

| Key          | Description                                           | Optional         |
|--------------|-------------------------------------------------------|------------------|
| `expect`     | The expected result of the test (see #expecters part) | No               |
| `times`      | How many times the method should be expect            | Yes (default: 10) |
| `description` | Set a custom description of the spec                  | Yes |
| `args`       | Set args to call the method in an array               | Yes |

## 📜 Expecters
Expecters are used to define the type of expectation you want to assert in your tests. They can be used to check conditions like greater than, less than, inclusion in an array, etc.


| Expecter  | Description                                          | Regex Match Examples                                  |
|-----------|------------------------------------------------------|-------------------------------------------------------|
| `Gt`      | Checks if result is greater than a value             | `expect: greater than 10`<br>`expect: > 10`           |
| `Ge`      | Checks if result is greater than or equal to a value | `expect: greater than or equal 10`<br>`expect: >= 10` |
| `Lt`      | Checks if result is less than a value                | `expect: less than 5`<br>`expect: < 5`                |
| `Include` | Checks if result is included in an array             | `expect: [true, false]`<br>`expect: [1, 2, 3]`        |

## 📃 Examples

```ruby
# spec:begin
# expect: greater than 5
# times: 5
# description: This test checks if the result is greater than 5
# args: [1, 2, 3]
# spec:end
def my_method(arg1, arg2, arg3)
  arg1 + arg2 + arg3
end
```

This will generate the following RSpec test:

```ruby
RSpec.describe 'my_method' do
  it 'This test checks if the result is greater than 5' do
    expect(my_method(1, 2, 3)).to be > 5
  end
end
```
____
```ruby
# spec:begin
# expect: [1, 2, 3]
# spec:end
def sample_method
  [1, 2, 3].sample
end
```

This will generate the following RSpec test:

```ruby
RSpec.describe 'sample_method' do
  it 'returns a value included in [1, 2, 3]' do
    expect(sample_method).to include(1, 2, 3)
  end
end
```

## 🔧 Contributing

Contributions are welcome and appreciated!

Whether you want to:

- Report a bug 🐛
- Suggest a new matcher ✨
- Improve documentation 📚
- Add tests 🧪
- Help with the CLI or Rails integration ⚙️

Feel free to open an [issue](https://github.com/richar-p/sharp_spec/issues) or submit a pull request.

### 🔨 To get started

1. Fork this repository
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add new feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Create a new Pull Request
