# spec:begin
# expect: [true, false]
# times: 4
# spec:end
def my_demo_method
  [true, false].sample
end

# spec:begin
# expect: > 4
# spec:end
def my_demo_method_gt = 10

# spec:begin
# expect: < 4
# args: [1, 3]
# spec:end
def my_demo_method_lt(a, b) = a - b

# spec:begin
# expect: >= 130
# times: 10
# description: "Check if the method returns a value greater than 130"
# args: [14, 16]
# spec:end
def my_demo_method_gt_130(a, b) = a * b